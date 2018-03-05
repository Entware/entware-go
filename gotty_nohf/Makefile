#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gotty_nohf
PKG_VERSION:=0.0.13-2017-03-29
PKG_RELEASE:=1
PKG_GOGET:=github.com/yudai/gotty

GOPKG_SOURCE=GO_gotty-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=e721482e57bea8af9191a5732a8580b3c6c43d7d

#do not build both packages in parallel
PKG_BUILD_DEPENDS:=gotty

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk


GOARM=GOARM=5

define Package/gotty_nohf
	$(call Package/gopackage/Default)
	DEPENDS:=@TARGET_armv7_3_2||@TARGET_armv7_2_6
	TITLE:=GoTTY is a simple command line tool that turns your CLI tools into web applications (arm version with no hard float)
	URL:=https://github.com/yudai/gotty
endef

define Package/gotty_nohf/description
 GoTTY - Share your terminal as a web application.
endef

define Package/gotty_nohf/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/gotty $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/gotty
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/$(PKG_GOGET)/.gotty $(1)/opt/etc/gotty/gotty
	$(SED) 's!~/.!/opt/etc/gotty/!g' $(1)/opt/etc/gotty/gotty
endef

$(eval $(call BuildPackage,gotty_nohf))
