# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2022-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=lux
PKG_VERSION:=0.22.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=154292b36b704d64e7b072ef695e737576bd2d31
PKG_SOURCE_URL:=https://github.com/iawia002/lux
PKG_MIRROR_HASH:=286b9992cad69128ce6a6e4e9f0abbb151143c38cab99515ce2dd4102c153fe3

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/lux/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Download Manager
	TITLE:=a fast, simple and clean video downloader
	URL:=https://github.com/iawia002/lux
	MAINTAINER:=Entware team, https://entware.net
	DEPENDS:=+ffmpeg
endef

define Package/lux
	$(call Package/lux/Default)
	VARIANT:=hf
endef

define Package/lux_nohf
	$(call Package/lux/Default)
	VARIANT:=nohf
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/lux/description
 A fast, simple and clean video downloader built with Go (command line).
endef

Package/lux_nohf/description=$(Package/lux/description)

GO_VARS += GO111MODULE=on

define Package/lux/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/lux $(1)/opt/bin
endef

Package/lux_nohf/install=$(Package/lux/install)

$(eval $(call BuildPackage,lux))
$(eval $(call BuildPackage,lux_nohf))
