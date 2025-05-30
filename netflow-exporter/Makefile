# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2025 Entware
#
# based on fork from paihu/netflow_exporter

include $(TOPDIR)/rules.mk

PKG_NAME:=netflow-exporter
PKG_VERSION:=0.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2021-11-22
PKG_SOURCE_VERSION:=b28b09684a775fa069da642606709db98cac6abb
PKG_SOURCE_URL:=https://github.com/AlfredArouna/netflow_exporter
PKG_MIRROR_HASH:=7328cdf332521bad28448cca70eb6abba02b0b76ce078b831ac1ffadfa622862

PKG_LICENSE:=
PKG_LICENSE_FILES:=

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/netflow-exporter/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=Prometheus netflow Exporter
  URL:=https://github.com/AlfredArouna/netflow_exporter
  MAINTAINER:=Entware team, https://entware.net
endef

define Package/netflow-exporter
  $(call Package/netflow-exporter/Default)
  VARIANT:=hf
endef

define Package/netflow-exporter_nohf
  $(call Package/netflow-exporter/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/netflow-exporter/description
  This is an exporter that exposes information gathered from netflow
  for use by the Prometheus monitoring system.
endef

Package/netflow-exporter_nohf/description=$(Package/netflow-exporter/description)

GO_LDFLAGS += \
	-X 'github.com/prometheus/common/version.Version=$(PKG_VERSION)' \
	-X 'github.com/prometheus/common/version.Revision=$(COMMIT_SHORT)'  \
	-X 'github.com/prometheus/common/version.Branch="master"' \
	-X 'github.com/prometheus/common/version.BuildUser=Entware@Entware' \
	-X 'github.com/prometheus/common/version.BuildDate=$(PKG_SOURCE_DATE)'

define Build/Compile
	( cd $(PKG_BUILD_DIR); rm -f ipdb.go; $(GO_BIN_MOD_TIDY); )
	$(call Build/Compile/Go)
endef

define Package/netflow-exporter/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/netflow_exporter $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99netflow_exporter $(1)/opt/etc/init.d
endef

Package/netflow-exporter_nohf/install=$(Package/netflow-exporter/install)

$(eval $(call BuildPackage,netflow-exporter))
$(eval $(call BuildPackage,netflow-exporter_nohf))
