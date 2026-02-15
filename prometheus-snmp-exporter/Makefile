# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-snmp-exporter
PKG_VERSION:=0.30.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2026-01-06
PKG_SOURCE_VERSION:=48b810afbd9222b74439ad1cf7d0d7b7c0cf4290
PKG_SOURCE_URL:=https://github.com/prometheus/snmp_exporter
PKG_MIRROR_HASH:=33c4687b62e4cfec5b3975f964bd624932beab860258242c69c87169e29dcf73

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/prometheus-snmp-exporter/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=SNMP Exporter for Prometheus
  URL:=https://prometheus.io/
  PROVIDES:=prometheus-snmp-exporter
endef

define Package/prometheus-snmp-exporter
  $(call Package/prometheus-snmp-exporter/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/prometheus-snmp-exporter_nohf
  $(call Package/prometheus-snmp-exporter/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/prometheus-snmp-exporter/description
  This exporter is the recommended way to expose SNMP data
  in a format which Prometheus can ingest.
endef

Package/prometheus-snmp-exporter_nohf/description=$(Package/prometheus-snmp-exporter/description)

GO_BUILD_ARGS += -a

GO_LDFLAGS += \
	-X 'github.com/prometheus/common/version.Version=v$(PKG_VERSION)' \
	-X 'github.com/prometheus/common/version.Revision=$(COMMIT_SHORT)'  \
	-X 'github.com/prometheus/common/version.Branch="release"' \
	-X 'github.com/prometheus/common/version.BuildUser=Entware@Entware' \
	-X 'github.com/prometheus/common/version.BuildDate=$(PKG_SOURCE_DATE)'

GO_TAGS:=netgo

define Package/prometheus-snmp-exporter/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/snmp_exporter $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99snmp_exporter $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/prometheus/snmp_exporter
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/snmp.yml $(1)/opt/etc/prometheus/snmp_exporter
endef

Package/prometheus-snmp-exporter_nohf/install=$(Package/prometheus-snmp-exporter/install)

$(eval $(call BuildPackage,prometheus-snmp-exporter))
$(eval $(call BuildPackage,prometheus-snmp-exporter_nohf))
