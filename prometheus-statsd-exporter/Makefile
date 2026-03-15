# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-statsd-exporter
PKG_VERSION:=0.29.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2026-03-05
PKG_SOURCE_VERSION:=595c7742c20fcfa691d21618201ae957b1f00945
PKG_SOURCE_URL:=https://github.com/prometheus/statsd_exporter
PKG_MIRROR_HASH:=734e365605aa03b499ed7f75b6aeab8c25574d5f6d19fd34c0248a6d6ef1f4bf

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/prometheus-statsd-exporter/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=StatsD to Prometheus metrics exporter
  URL:=https://prometheus.io/
  PROVIDES:=prometheus-statsd-exporter
endef

define Package/prometheus-statsd-exporter
  $(call Package/prometheus-statsd-exporter/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/prometheus-statsd-exporter_nohf
  $(call Package/prometheus-statsd-exporter/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/prometheus-statsd-exporter/description
  statsd_exporter receives StatsD-style metrics and exports them
  as Prometheus metrics.
endef

Package/prometheus-statsd-exporter_nohf/description=$(Package/prometheus-statsd-exporter/description)

define Package/prometheus-statsd-exporter/conffiles
/opt/etc/prometheus/statsd_mapping.yml
endef

Package/prometheus-statsd-exporter_nohf/conffiles=$(Package/prometheus-statsd-exporter/conffiles)

GO_BUILD_ARGS += -a

GO_LDFLAGS += \
	-X 'github.com/prometheus/common/version.Version=$(PKG_VERSION)' \
	-X 'github.com/prometheus/common/version.Revision=$(COMMIT_SHORT)'  \
	-X 'github.com/prometheus/common/version.Branch="release"' \
	-X 'github.com/prometheus/common/version.BuildUser=Entware@Entware' \
	-X 'github.com/prometheus/common/version.BuildDate=$(PKG_SOURCE_DATE)'

GO_TAGS:=netgo, static_build

define Package/prometheus-statsd-exporter/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/statsd_exporter $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99statsd_exporter $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/prometheus
	$(INSTALL_DATA) ./files/statsd_mapping.yml $(1)/opt/etc/prometheus
endef

Package/prometheus-statsd-exporter_nohf/install=$(Package/prometheus-statsd-exporter/install)

$(eval $(call BuildPackage,prometheus-statsd-exporter))
$(eval $(call BuildPackage,prometheus-statsd-exporter_nohf))
