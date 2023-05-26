#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lux
PKG_VERSION:=0.18.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=e0729b067aff8b1115a9a78d76216e0f86a22ce3
PKG_SOURCE_URL:=https://github.com/iawia002/lux
PKG_MIRROR_HASH:=f4fec6790eb09997104df13aa50566e5038d45d07e01e35a6212a7e6f5d2fa5b

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
