# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware
#
# Project archived by the owner on Mar 8, 2023.

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-haproxy-exporter
PKG_VERSION:=0.15.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2023-02-15
PKG_SOURCE_VERSION:=d4aba878f043fd3ad0bcacd0149e7d75e67c0faa
PKG_SOURCE_URL:=https://github.com/prometheus/haproxy_exporter
PKG_MIRROR_HASH:=8e8c64ccc7e3b0a530516d91ece818fd9260b77c73a22c69ac3273101b8a66c5

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

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
  DEPENDS+=@arm
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

GO_TAGS:=netgo

define Package/prometheus-haproxy-exporter/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/haproxy_exporter $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99haproxy_exporter $(1)/opt/etc/init.d
endef

Package/prometheus-haproxy-exporter_nohf/install=$(Package/prometheus-haproxy-exporter/install)

$(eval $(call BuildPackage,prometheus-haproxy-exporter))
$(eval $(call BuildPackage,prometheus-haproxy-exporter_nohf))
