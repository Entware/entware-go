# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-collectd-exporter
PKG_VERSION:=0.6.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2020-12-09
PKG_SOURCE_VERSION:=97668d16288554a7bb5ce2b611cdf475e22f464a
PKG_SOURCE_URL:=https://github.com/prometheus/collectd_exporter
PKG_MIRROR_HASH:=7ea2e4c4255123c2aa75e761a53a63ad62f743b9480e53d0d404bcbcc085e053

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/prometheus-collectd-exporter/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=Collectd Exporter
  URL:=https://prometheus.io/
  MAINTAINER:=Entware team, https://entware.net
  DEPENDS:=+collectd
endef

define Package/prometheus-collectd-exporter
  $(call Package/prometheus-collectd-exporter/Default)
  VARIANT:=hf
endef

define Package/prometheus-collectd-exporter_nohf
  $(call Package/prometheus-collectd-exporter/Default)
  VARIANT:=nohf
  DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/prometheus-collectd-exporter/description
  A server that accepts collectd stats via HTTP POST and exports
  them via HTTP for Prometheus consumption.
endef

Package/prometheus-collectd-exporter_nohf/description=$(Package/prometheus-collectd-exporter/description)

GO_BUILD_ARGS += -a

GO_LDFLAGS += \
	-X 'github.com/prometheus/common/version.Version=$(PKG_VERSION)' \
	-X 'github.com/prometheus/common/version.Revision=$(COMMIT_SHORT)'  \
	-X 'github.com/prometheus/common/version.Branch="release"' \
	-X 'github.com/prometheus/common/version.BuildUser=Entware@Entware' \
	-X 'github.com/prometheus/common/version.BuildDate=$(PKG_SOURCE_DATE)'

GO_TAGS:=-tags=netgo

define Package/prometheus-collectd-exporter/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/collectd_exporter $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99collectd_exporter $(1)/opt/etc/init.d
endef

Package/prometheus-collectd-exporter_nohf/install=$(Package/prometheus-collectd-exporter/install)

$(eval $(call BuildPackage,prometheus-collectd-exporter))
$(eval $(call BuildPackage,prometheus-collectd-exporter_nohf))
