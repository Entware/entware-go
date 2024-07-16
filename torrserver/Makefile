# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=torrserver
PKG_VERSION:=1.2.133
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=cf8aa54dee699676547aa0af33e33e7b2e83660d
PKG_SOURCE_URL:=https://github.com/YouROK/TorrServer
PKG_MIRROR_HASH:=6d6f595c6a3d193e7182b173d2d1c29b109252381d148bb8ac75190178cd19f2

PKG_BUILD_DEPENDS:=node-yarn/host
PKG_BUILD_PARALLEL:=1
PKG_CGO_ENABLED:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/torrserver/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=BitTorrent
	TITLE:=stream torrent to http
	URL:=https://github.com/YouROK/TorrServer
	MAINTAINER:=Entware team, https://entware.net
	DEPENDS:=+libstdcpp
endef

define Package/torrserver
	$(call Package/torrserver/Default)
	VARIANT:=hf
endef

define Package/torrserver_nohf
	$(call Package/torrserver/Default)
	VARIANT:=nohf
	DEPENDS+=@arm
endef

define Package/torrserver/description
 torrserver is a server to stream torrent via http to torrserv client.
endef

Package/torrserver_nohf/description=$(Package/torrserver/description)

GO_SRC_SUBDIR:=server
GO_TAGS:=nosqlite
GO_TARGET:=./cmd

define PreBuild
	( cd $(PKG_BUILD_DIR); \
		NODE_OPTIONS=--openssl-legacy-provider \
		$(GO_ENV_COMMON) $(GO_BIN) run \
		$(if $(findstring s,$(OPENWRT_VERBOSE)),-v -x) \
		gen_web.go; \
	)
	( cd $(PKG_BUILD_DIR)/server; $(GO_BIN_MOD_TIDY); )
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
