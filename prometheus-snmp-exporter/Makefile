# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-snmp-exporter
PKG_VERSION:=0.25.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2023-12-10
PKG_SOURCE_VERSION:=9c42d6c874d479314e612bca69558c81f8e26287
PKG_SOURCE_URL:=https://github.com/prometheus/snmp_exporter
PKG_MIRROR_HASH:=980714c4a1988a574bb7019585abd462c64625ce5ad5a58a45f9ce6f3471728a

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/prometheus-snmp-exporter/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=SNMP Exporter for Prometheus
  URL:=https://prometheus.io/
  MAINTAINER:=Entware team, https://entware.net
endef

define Package/prometheus-snmp-exporter
  $(call Package/prometheus-snmp-exporter/Default)
  VARIANT:=hf
endef

define Package/prometheus-snmp-exporter_nohf
  $(call Package/prometheus-snmp-exporter/Default)
  VARIANT:=nohf
  DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
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

GO_TAGS:=-tags=netgo

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
