#
# Copyright (C) 2023 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus
PKG_VERSION:=2.44.0
PKG_RELEASE:=1
SOURCE_DATE:=2023-05-13

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=1ac5131f698ebc60f13fe2727f89b115a41f6558
PKG_SOURCE_URL:=https://github.com/prometheus/prometheus
PKG_MIRROR_HASH:=8ec4774163b1d5560bc2232fb5807b173050dc2c4e8725169948f31f2bd774f8

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=node/host

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/prometheus/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=Monitoring system and time series database
  URL:=http://prometheus.io
  MAINTAINER:=Entware team, https://entware.net
endef

define Package/prometheus
  $(call Package/prometheus/Default)
  VARIANT:=hf
endef

define Package/prometheus_nohf
  $(call Package/prometheus/Default)
  VARIANT:=nohf
  DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/prometheus/description
  Prometheus, a Cloud Native Computing Foundation project,
  is a systems and service monitoring system. It collects
  metrics from configured targets at given intervals, evaluates
  rule expressions, displays the results, and can trigger alerts
  when specified conditions are observed.
endef

Package/prometheus_nohf/description=$(Package/prometheus/description)

define Package/prometheus/conffiles
/opt/etc/prometheus/prometheus.yml
endef

Package/prometheus_nohf/conffiles=$(Package/prometheus/conffiles)

GO_BUILD_ARGS += -a

GO_LDFLAGS += \
	-X 'github.com/prometheus/common/version.Version=v$(PKG_VERSION)' \
	-X 'github.com/prometheus/common/version.Revision=$(COMMIT_SHORT)'  \
	-X 'github.com/prometheus/common/version.Branch="release"' \
	-X 'github.com/prometheus/common/version.BuildUser=Entware@Entware' \
	-X 'github.com/prometheus/common/version.BuildDate=$(SOURCE_DATE)'

GO_TAGS:=-tags=netgo,builtinassets

GO_TARGET:=./cmd/...

GO_VARS += GO111MODULE=on

define Build/CompilePre
	( cd $(PKG_BUILD_DIR)/web/ui; npm install; CI="" npm run build; )
	( cd $(PKG_BUILD_DIR)/web/ui; \
		$(FIND) ./static -type f -a -name "*.map" -delete; )
	( cd $(PKG_BUILD_DIR); $(SHELL) scripts/compress_assets.sh; )
	( cd $(PKG_BUILD_DIR); $(GO_BIN) generate -tags plugins ./plugins; )
endef

Hooks/Compile/Pre += Build/CompilePre

define Package/prometheus/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/prom{etheus,tool} $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/prometheus
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/documentation/examples/prometheus.yml \
			$(1)/opt/etc/prometheus
	$(CP) $(PKG_BUILD_DIR)/console{s,_libraries} $(1)/opt/etc/prometheus
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S70prometheus $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/var/lib/prometheus
endef

Package/prometheus_nohf/install=$(Package/prometheus/install)

$(eval $(call BuildPackage,prometheus))
$(eval $(call BuildPackage,prometheus_nohf))