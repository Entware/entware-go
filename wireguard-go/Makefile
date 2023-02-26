#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=wireguard-go
PKG_VERSION:=v0.0.20230223
PKG_RELEASE:=1

PKG_GOGET:=git.zx2c4.com/wireguard-go

PKG_SOURCE_VERSION:=e24fc776e0ffb6e3c293895163d95bdd8a3c386f

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=74526664fae85117381339550b691ae4e8382fff3814ad8c23d16c78cd452da3

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/wireguard-go/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=VPN
	TITLE:=This is an implementation of WireGuard in Go
	URL:=https://git.zx2c4.com/wireguard-go/about/
	MAINTAINER:=Entware team, https://entware.net
	DEPENDS:=+wireguard-tools +wg-quick @!LINUX_2_6_36
endef

define Package/wireguard-go
	$(call Package/wireguard-go/Default)
	VARIANT:=hf
endef

define Package/wireguard-go_nohf
	$(call Package/wireguard-go/Default)
	VARIANT:=nohf
	DEPENDS+=@TARGET_armv7_3_2
endef

define Package/wireguard-go/description
 This is an implementation of WireGuard in Go.
endef

Package/wireguard-go_nohf/description=$(Package/wireguard-go/description)

define Package/wireguard-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/wireguard $(1)/opt/bin/wireguard-go
endef

Package/wireguard-go_nohf/install=$(Package/wireguard-go/install)

$(eval $(call BuildPackage,wireguard-go))
$(eval $(call BuildPackage,wireguard-go_nohf))
