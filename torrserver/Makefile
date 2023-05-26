#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=torrserver
PKG_VERSION:=1.2.123
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=48bff20df9f31ebfa3e869dd1c49df9c638c6896
PKG_SOURCE_URL:=https://github.com/YouROK/TorrServer
PKG_MIRROR_HASH:=ef285d8a6e39c5bfcb2919a1d72ff99cbab652d24383538e16cdfc9e432d1eb3

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/torrserver/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=BitTorrent
	TITLE:=TorrServer - stream torrent to http
	URL:=https://github.com/YouROK/TorrServer
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/torrserver
	$(call Package/torrserver/Default)
	VARIANT:=hf
endef

define Package/torrserver_nohf
	$(call Package/torrserver/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/torrserver/description
 torrserver is a server to stream torrent via http to torrserv client
endef

Package/torrserver_nohf/description=$(Package/torrserver/description)

GO_SRC_SUBDIR:=server
GO_TAGS:=-tags=nosqlite
GO_TARGET:=./cmd

define PreBuild
        ( cd $(PKG_BUILD_DIR)/server; $(GO_BIN) mod tidy; )
endef

Hooks/Compile/Pre += PreBuild

define Package/torrserver/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/cmd $(1)/opt/sbin/torrserver
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S90torrserver $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/torrserver
	touch $(1)/opt/etc/torrserver/.keep
endef

Package/torrserver_nohf/install=$(Package/torrserver/install)

$(eval $(call BuildPackage,torrserver))
$(eval $(call BuildPackage,torrserver_nohf))
