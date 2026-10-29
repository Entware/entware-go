# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2019-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=adguardhome
PKG_VERSION:=v0.107.79
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2026-08-17
PKG_SOURCE_VERSION:=05ba17b282da1c4393d6a4ba4db0cf519194a362
PKG_SOURCE_URL:=https://github.com/AdguardTeam/AdGuardHome
PKG_MIRROR_HASH:=cd00dd7f9bc640113c4bfc8aaa79b8f4366e3e8d799ccd3969704712fb16d0e0

PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE.txt
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/adguardhome/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Network-wide ads & trackers blocking DNS server
  URL:=https://adguard.com/adguard-home.html
  PROVIDES:=adguardhome adguardhome-go
  EXTRA_DEPENDS:=ca-bundle
endef

define Package/adguardhome-go
  $(call Package/adguardhome/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/adguardhome-go_nohf
  $(call Package/adguardhome/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/adguardhome-go/description
  AdGuard Home is a network-wide software for blocking ads and tracking.
endef

Package/adguardhome-go_nohf/description=$(Package/adguardhome-go/description)

define Package/adguardhome-go/conffiles
/opt/etc/AdGuardHome/adguardhome.conf
endef

Package/adguardhome-go_nohf/conffiles=$(Package/adguardhome-go/conffiles)

AGH_FRONTEND:=$(PKG_NAME)-frontend-$(PKG_VERSION).tar.gz
define Download/adguardhome-frontend
  URL:=$(PKG_SOURCE_URL)/releases/download/$(PKG_VERSION)/
  URL_FILE:=AdGuardHome_frontend.tar.gz
  FILE:=$(AGH_FRONTEND)
  HASH:=30184c157d4aefe5371b575a43c0ab5a7314aef039a820cc421ea67bab994ce8
endef

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/internal/version.channel=release' \
	-X '$(XIMPORTPATH)/internal/version.version=$(PKG_VERSION)' \
	-X '$(XIMPORTPATH)/internal/version.committime=$(PKG_SOURCE_DATE)'

define Build/Prepare
	$(call Build/Prepare/Default)
	$(TAR) -xf $(DL_DIR)/$(AGH_FRONTEND) --strip-components=1 -C $(PKG_BUILD_DIR)
endef

define Package/adguardhome-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/AdGuardHome $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99adguardhome $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/AdGuardHome
	$(INSTALL_CONF) ./files/adguardhome.conf $(1)/opt/etc/AdGuardHome
endef

Package/adguardhome-go_nohf/install=$(Package/adguardhome-go/install)

$(eval $(call Download,adguardhome-frontend))
$(eval $(call BuildPackage,adguardhome-go))
$(eval $(call BuildPackage,adguardhome-go_nohf))
