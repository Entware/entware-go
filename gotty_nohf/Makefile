#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gotty_nohf
PKG_VERSION:=0.0.13-2017-01-09
PKG_RELEASE:=1
PKG_GOGET:=github.com/yudai/gotty

GOPKG_SOURCE=GO_gotty-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=92d8d62ae1f52bdfcefb8985f2a1c27c6cfe2228

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk


GOARM=GOARM=5

define Package/gotty_nohf
	$(call Package/gopackage/Default)
	DEPENDS:=@TARGET_armv7_3x
	TITLE:=GoTTY is a simple command line tool that turns your CLI tools into web applications (arm version with no hard float)
	URL:=https://github.com/yudai/gotty
endef

define Package/gotty_nohf/description
 GoTTY - Share your terminal as a web application.
endef

define Package/gotty_nohf/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/gotty $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/$(PKG_NAME)
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/src/$(PKG_GOGET)/.gotty $(1)/opt/etc/$(PKG_NAME)/gotty
	$(SED) 's!~/.!/opt/etc/gotty/!g' $(1)/opt/etc/$(PKG_NAME)/gotty
endef

$(eval $(call BuildPackage,gotty_nohf))
