# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-blackbox-exporter
PKG_VERSION:=0.24.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2023-05-16
PKG_SOURCE_VERSION:=0b0467473916fd9e8526e2635c2a0b1c56011dff
PKG_SOURCE_URL:=https://github.com/prometheus/blackbox_exporter
PKG_MIRROR_HASH:=1ecd9495d0aee4b4a45978b4ad54a47adf5eddbd16060b939a24ae29683c9b65

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/prometheus-blackbox-exporter/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=Blackbox prober exporter
  URL:=https://prometheus.io/
  MAINTAINER:=Entware team, https://entware.net
endef

define Package/prometheus-blackbox-exporter
  $(call Package/prometheus-blackbox-exporter/Default)
  VARIANT:=hf
endef

define Package/prometheus-blackbox-exporter_nohf
  $(call Package/prometheus-blackbox-exporter/Default)
  VARIANT:=nohf
  DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/prometheus-blackbox-exporter/description
  The blackbox exporter allows blackbox probing of endpoints
  over HTTP, HTTPS, DNS, TCP, ICMP and gRPC.
endef

Package/prometheus-blackbox-exporter_nohf/description=$(Package/prometheus-blackbox-exporter/description)

define Package/blackbox_exporter/conffiles
/opt/etc/prometheus/blackbox.yml
endef

Package/blackbox_exporter_nohf/conffiles=$(Package/blackbox_exporter/conffiles)

GO_BUILD_ARGS += -a

GO_LDFLAGS += \
	-X 'github.com/prometheus/common/version.Version=$(PKG_VERSION)' \
	-X 'github.com/prometheus/common/version.Revision=$(COMMIT_SHORT)'  \
	-X 'github.com/prometheus/common/version.Branch="release"' \
	-X 'github.com/prometheus/common/version.BuildUser=Entware@Entware' \
	-X 'github.com/prometheus/common/version.BuildDate=$(PKG_SOURCE_DATE)'

GO_TAGS:=-tags=netgo

define Package/prometheus-blackbox-exporter/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/blackbox_exporter $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99blackbox_exporter $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/prometheus
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/blackbox.yml $(1)/opt/etc/prometheus
endef

Package/prometheus-blackbox-exporter_nohf/install=$(Package/prometheus-blackbox-exporter/install)

$(eval $(call BuildPackage,prometheus-blackbox-exporter))
$(eval $(call BuildPackage,prometheus-blackbox-exporter_nohf))
