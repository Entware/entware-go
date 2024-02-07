# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware
#
# # Project archived by the owner on Mar 8, 2023.

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-haproxy-exporter
PKG_VERSION:=0.15.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2023-02-15
PKG_SOURCE_VERSION:=d4aba878f043fd3ad0bcacd0149e7d75e67c0faa
PKG_SOURCE_URL:=https://github.com/prometheus/haproxy_exporter
PKG_MIRROR_HASH:=79465cffcab87aa80f3a981078a76a8c560ebe99c83852b30d4097a38bb2edd3

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/prometheus-haproxy-exporter/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=HAProxy Exporter for Prometheus
  URL:=https://prometheus.io/
  MAINTAINER:=Entware team, https://entware.net
  DEPENDS:=+haproxy
endef

define Package/prometheus-haproxy-exporter
  $(call Package/prometheus-haproxy-exporter/Default)
  VARIANT:=hf
endef

define Package/prometheus-haproxy-exporter_nohf
  $(call Package/prometheus-haproxy-exporter/Default)
  VARIANT:=nohf
  DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/prometheus-haproxy-exporter/description
  Simple server that scrapes HAProxy stats and exports
  them via HTTP for Prometheus consumption.
endef

Package/prometheus-haproxy-exporter_nohf/description=$(Package/prometheus-haproxy-exporter/description)

GO_BUILD_ARGS += -a

GO_LDFLAGS += \
	-X 'github.com/prometheus/common/version.Version=$(PKG_VERSION)' \
	-X 'github.com/prometheus/common/version.Revision=$(COMMIT_SHORT)'  \
	-X 'github.com/prometheus/common/version.Branch="release"' \
	-X 'github.com/prometheus/common/version.BuildUser=Entware@Entware' \
	-X 'github.com/prometheus/common/version.BuildDate=$(PKG_SOURCE_DATE)'

GO_TAGS:=-tags=netgo

define Package/prometheus-haproxy-exporter/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/haproxy_exporter $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99haproxy_exporter $(1)/opt/etc/init.d
endef

Package/prometheus-haproxy-exporter_nohf/install=$(Package/prometheus-haproxy-exporter/install)

$(eval $(call BuildPackage,prometheus-haproxy-exporter))
$(eval $(call BuildPackage,prometheus-haproxy-exporter_nohf))
