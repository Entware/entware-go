#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asciinema-ng
PKG_VERSION:=2016-03-02
PKG_RELEASE:=1
PKG_GOGET:=github.com/asciinema/asciinema

GOARCH=GOARCH_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
#PKG_SOURCE=$(GOARCH)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/asciinema-ng
	$(call Package/gopackage/Default)
	TITLE:=Terminal session recorder (go version) 
	URL:=https://asciinema.org/
endef

define Package/asciinema-ng/description
 asciinema is a free and open source solution for recording terminal sessions and sharing them on the web
endef

define Package/asciinema-ng/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/asciinema $(1)/opt/bin
endef

$(eval $(call BuildPackage,asciinema-ng))
