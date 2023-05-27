#
# Copyright (C) 2023 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-statsd-exporter
PKG_VERSION:=0.23.1
PKG_RELEASE:=1
SOURCE_DATE:=2023-03-08

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=14d18d8e70979f80b426a4ca78ca438da4652e78
PKG_SOURCE_URL:=https://github.com/prometheus/statsd_exporter
PKG_MIRROR_HASH:=add342fbda96ac41a64f915435489d76712520cf370ee37ca15e1ecbeadcc752

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/prometheus-statsd-exporter/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=StatsD to Prometheus metrics exporter
  URL:=https://prometheus.io/
  MAINTAINER:=Entware team, https://entware.net
endef

define Package/prometheus-statsd-exporter
  $(call Package/prometheus-statsd-exporter/Default)
  VARIANT:=hf
endef

define Package/prometheus-statsd-exporter_nohf
  $(call Package/prometheus-statsd-exporter/Default)
  VARIANT:=nohf
  DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
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
	-X 'github.com/prometheus/common/version.BuildDate=$(SOURCE_DATE)'

GO_TAGS:=-tags=netgo,static_build

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
