# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=alertmanager
PKG_VERSION:=0.27.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-02-28
PKG_SOURCE_VERSION:=0aa3c2aad14cff039931923ab16b26b7481783b5
PKG_SOURCE_URL:=https://github.com/prometheus/alertmanager
PKG_MIRROR_HASH:=124c5c11086ee939d89f117e1653ae8a977e800d5955e67e406c911401aeb3ac

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=node/host
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/alertmanager/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=prometheus tools
  TITLE:=Prometheus Alertmanager
  URL:=http://prometheus.io
  MAINTAINER:=Entware team, https://entware.net
endef

define Package/alertmanager
  $(call Package/alertmanager/Default)
  VARIANT:=hf
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

GO_BUILD_ARGS += -a

GO_LDFLAGS += \
	-X 'github.com/prometheus/common/version.Version=v$(PKG_VERSION)' \
	-X 'github.com/prometheus/common/version.Revision=$(COMMIT_SHORT)'  \
	-X 'github.com/prometheus/common/version.Branch="release"' \
	-X 'github.com/prometheus/common/version.BuildUser=Entware@Entware' \
	-X 'github.com/prometheus/common/version.BuildDate=$(PKG_SOURCE_DATE)'

GO_TAGS:=netgo
GO_TARGET:=./cmd/alertmanager ./cmd/amtool

define Package/alertmanager/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/{alertmanager,amtool} $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S90alertmanager $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/prometheus
	$(CP) $(PKG_BUILD_DIR)/examples/ha/alertmanager.yml $(1)/opt/etc/prometheus
endef

Package/alertmanager_nohf/install=$(Package/alertmanager/install)

$(eval $(call BuildPackage,alertmanager))
$(eval $(call BuildPackage,alertmanager_nohf))
