#
# Copyright (C) 2011-2024 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gost-go
PKG_VERSION:=v3.0.0-nightly.20240118
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=abfbf23842598d86ae2dab58501a5f05cbb28877
PKG_SOURCE_URL:=https://github.com/go-gost/gost
PKG_MIRROR_HASH:=skip

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/gost-go/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=VPN
	TITLE:=GO Simple Tunnel
	URL:=https://github.com/SagerNet/gost
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/gost-go
	$(call Package/gost-go/Default)
	VARIANT:=hf
endef

define Package/gost-go_nohf
	$(call Package/gost-go/Default)
	VARIANT:=nohf
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/gost-go/description
 A simple security tunnel written in golang
endef

Package/gost-go_nohf/description=$(Package/gost-go/description)

GO_TARGET:=./cmd/gost

define Package/gost-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/gost $(1)/opt/bin/
endef

Package/gost-go_nohf/install=$(Package/gost-go/install)

$(eval $(call BuildPackage,gost-go))
$(eval $(call BuildPackage,gost-go_nohf))
