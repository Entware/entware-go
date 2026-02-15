# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=prometheus-node-exporter
PKG_VERSION:=1.10.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2025-10-25
PKG_SOURCE_VERSION:=654f19dee6a0c41de78a8d6d870e8c742cdb43b9
PKG_SOURCE_URL:=https://github.com/prometheus/node_exporter
PKG_MIRROR_HASH:=36299d2e3d55fa02d89afb1bff49b6b3ff2e395139bfd95858c55da8418b6b97

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/prometheus-node-exporter/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=Exporter for machine metrics
  URL:=https://prometheus.io/
  PROVIDES:=prometheus-node-exporter
endef

define Package/prometheus-node-exporter
  $(call Package/prometheus-node-exporter/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/prometheus-node-exporter_nohf
  $(call Package/prometheus-node-exporter/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/prometheus-node-exporter/description
  Prometheus exporter for hardware and OS metrics exposed by *NIX
  kernels, written in Go with pluggable metric collectors.
endef

Package/prometheus-node-exporter_nohf/description=$(Package/prometheus-node-exporter/description)

GO_BUILD_ARGS += -a

GO_LDFLAGS += \
	-X 'github.com/prometheus/common/version.Version=v$(PKG_VERSION)' \
	-X 'github.com/prometheus/common/version.Revision=$(COMMIT_SHORT)'  \
	-X 'github.com/prometheus/common/version.Branch="release"' \
	-X 'github.com/prometheus/common/version.BuildUser=Entware@Entware' \
	-X 'github.com/prometheus/common/version.BuildDate=$(PKG_SOURCE_DATE)'

GO_TAGS:=netgo, osusergo, static_build

define Package/prometheus-node-exporter/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/node_exporter $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99node_exporter $(1)/opt/etc/init.d
endef

Package/prometheus-node-exporter_nohf/install=$(Package/prometheus-node-exporter/install)

$(eval $(call BuildPackage,prometheus-node-exporter))
$(eval $(call BuildPackage,prometheus-node-exporter_nohf))
