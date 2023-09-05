#
# Copyright (C) 2023 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-collectd-exporter
PKG_VERSION:=0.5.0
PKG_RELEASE:=1
SOURCE_DATE:=2020-05-08

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=8e37c190f875eca9b72db522f4acdbb72884225c
PKG_SOURCE_URL:=https://github.com/prometheus/collectd_exporter
PKG_MIRROR_HASH:=78a545d24e8911f4918b2d3646f7efe8c8a8c263804ebb9a8d4c32d7513ff885

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
	-X 'github.com/prometheus/common/version.BuildDate=$(SOURCE_DATE)'

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
