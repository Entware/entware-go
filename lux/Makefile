#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=lux
PKG_VERSION:=0.19.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=092bc0f6c18f81e1441ac17b2d053e74d7e6ddfe
PKG_SOURCE_URL:=https://github.com/iawia002/lux
PKG_MIRROR_HASH:=e0964b426f0371a62126ad1b0f07879921cf8e2118356e05984b166e75c63c8d

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
