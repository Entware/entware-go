# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-collectd-exporter
PKG_VERSION:=0.7.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-11-07
PKG_SOURCE_VERSION:=91d0c4593229a396b3076762710268efa7dd4133
PKG_SOURCE_URL:=https://github.com/prometheus/collectd_exporter
PKG_MIRROR_HASH:=4d2df1988a8567724e9029b0a6493c19b0f10febad62f6c3eb84997a94848eba

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

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
  DEPENDS+=@arm
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

GO_TAGS:=netgo

define Package/prometheus-collectd-exporter/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/collectd_exporter $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99collectd_exporter $(1)/opt/etc/init.d
endef

Package/prometheus-collectd-exporter_nohf/install=$(Package/prometheus-collectd-exporter/install)

$(eval $(call BuildPackage,prometheus-collectd-exporter))
$(eval $(call BuildPackage,prometheus-collectd-exporter_nohf))
