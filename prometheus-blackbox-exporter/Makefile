# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-blackbox-exporter
PKG_VERSION:=0.25.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-04-09
PKG_SOURCE_VERSION:=ef3ff4fef195333fb8ee0039fb487b2f5007908f
PKG_SOURCE_URL:=https://github.com/prometheus/blackbox_exporter
PKG_MIRROR_HASH:=ee933e47105e6d85f895a9e9f0db87632c2308a7561b129c2af79d8a2c128ecc

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

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
  DEPENDS:=@arm
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

GO_TAGS:=netgo

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
