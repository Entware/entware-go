# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=alertmanager
PKG_VERSION:=0.34.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2026-09-17
PKG_SOURCE_VERSION:=73c6bfe7393929211294c1954f30d8ed78e4d0ad
PKG_SOURCE_URL:=https://github.com/prometheus/alertmanager
PKG_MIRROR_HASH:=487c56bf44e4b2174152bcc9555dc61fce41bea1927d718b821198a80c9ba898

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/alertmanager/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=Prometheus Alertmanager
  URL:=http://prometheus.io
  PROVIDES:=alertmanager
endef

define Package/alertmanager
  $(call Package/alertmanager/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/alertmanager_nohf
  $(call Package/alertmanager/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/alertmanager/description
  The Alertmanager handles alerts sent by client applications such
  as the Prometheus server. It takes care of deduplicating, grouping,
  and routing them to the correct receiver integrations such as email,
  PagerDuty, OpsGenie, or many other mechanisms thanks to the webhook
  receiver. It also takes care of silencing and inhibition of alerts.
endef

Package/alertmanager_nohf/description=$(Package/alertmanager/description)

define Package/alertmanager/conffiles
/opt/etc/prometheus/alertmanager.yml
endef

Package/alertmanager_nohf/conffiles=$(Package/alertmanager/conffiles)

WEB_FILE:=$(PKG_NAME)-web-ui-$(PKG_VERSION).tar.gz
define Download/alertmanager-web-ui
  URL:=$(PKG_SOURCE_URL)/releases/download/v$(PKG_VERSION)/
  URL_FILE:=$(WEB_FILE)
  FILE:=$(WEB_FILE)
  HASH:=881fe0f7beb9573f35be47dd233af6220e72c8db72c03bcd1780402eb8dc1307
endef

GO_LDFLAGS += \
	-X 'github.com/prometheus/common/version.Version=v$(PKG_VERSION)' \
	-X 'github.com/prometheus/common/version.Revision=$(COMMIT_SHORT)'  \
	-X 'github.com/prometheus/common/version.Branch="release"' \
	-X 'github.com/prometheus/common/version.BuildUser=Entware@Entware' \
	-X 'github.com/prometheus/common/version.BuildDate=$(PKG_SOURCE_DATE)'

GO_TAGS:=netgo
GO_TARGET:=./cmd/alertmanager ./cmd/amtool

define Build/Prepare
	$(call Build/Prepare/Default)
	$(HOST_TAR) -xzf $(DL_DIR)/$(WEB_FILE) -C $(PKG_BUILD_DIR)/ui/app
endef

define Package/alertmanager/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/{alertmanager,amtool} $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S90alertmanager $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/prometheus
	$(CP) $(PKG_BUILD_DIR)/examples/ha/alertmanager.yml $(1)/opt/etc/prometheus
endef

Package/alertmanager_nohf/install=$(Package/alertmanager/install)

$(eval $(call Download,alertmanager-web-ui))
$(eval $(call BuildPackage,alertmanager))
$(eval $(call BuildPackage,alertmanager_nohf))
