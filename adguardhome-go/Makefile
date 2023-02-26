#
# Copyright (C) 2019-2022 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=adguardhome
PKG_VERSION:=v0.107.25
PKG_RELEASE:=1

PKG_GOGET:=github.com/AdguardTeam/AdGuardHome

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=4f928be39318cfc784a7a0a3337ef7506a99433e
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=638f3baaa5a7f86c06d7c7678fc84ba2c389feebb9862aedd84367f4d0668e20

PKG_LICENSE:=GPL-3.0-only
PKG_LICENSE_FILES:=LICENSE.txt

PKG_BUILD_DEPENDS:=node-yarn/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/adguardhome-go/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Network-wide ads & trackers blocking DNS server
  URL:=https://adguard.com/adguard-home.html
  MAINTAINER:=Entware team, https://entware.net
  DEPENDS:=+ca-bundle
endef

define Package/adguardhome-go
  $(call Package/adguardhome-go/Default)
  VARIANT:=hf
endef

define Package/adguardhome-go_nohf
  $(call Package/adguardhome-go/Default)
  VARIANT:=nohf
  DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/adguardhome-go/description
  AdGuard Home is a network-wide software for blocking ads and tracking.
endef

Package/adguardhome-go_nohf/description=$(Package/adguardhome-go/description)

define Package/adguardhome-go/conffiles
/opt/etc/AdGuardHome/adguardhome.conf
/opt/etc/hosts
endef

Package/adguardhome-go_nohf/conffiles=$(Package/adguardhome-go/conffiles)

BUILDTIME:=$(shell date -u +%FT%TZ%z)

GO_LDFLAGS += \
	-X '$(PKG_GOGET)/internal/version.channel=release' \
	-X '$(PKG_GOGET)/internal/version.version=$(PKG_VERSION)' \
	-X '$(PKG_GOGET)/internal/version.buildtime=$(BUILDTIME)'

define Build/Web
	( cd $(GO_SRC_DIR); make js-deps js-build; )
endef

Hooks/Compile/Pre += Build/Web

define Package/adguardhome-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/AdGuardHome $(1)/opt/bin

	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) files/S99adguardhome $(1)/opt/etc/init.d

	$(INSTALL_DIR) $(1)/opt/etc/AdGuardHome
	$(INSTALL_CONF) files/adguardhome.conf $(1)/opt/etc/AdGuardHome

	touch $(1)/opt/etc/hosts
endef

Package/adguardhome-go_nohf/install=$(Package/adguardhome-go/install)

define Package/adguardhome-go/postinst
#!/bin/sh

if [ ! -s "/opt/etc/hosts" ]; then
  cat /etc/hosts > /opt/etc/hosts
fi
endef

Package/adguardhome-go_nohf/postinst=$(Package/adguardhome-go/postinst)

$(eval $(call BuildPackage,adguardhome-go))
$(eval $(call BuildPackage,adguardhome-go_nohf))
