#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=asciinema-ng
PKG_VERSION:=go
PKG_RELEASE:=1
PKG_GOGET:=github.com/asciinema/asciinema

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/asciinema-ng
	SECTION:=Go
	CATEGORY:=Go
	DEPENDS:=+libgo +libpthread
	TITLE:=Terminal session recorder (go version) 
	URL:=https://asciinema.org/
	MAINTAINER:=Entware team, http://entware.net
endef

define Package/asciinema-ng/description
 asciinema is a free and open source solution for recording terminal sessions and sharing them on the web
endef

define Package/asciinema-ng/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/asciinema $(1)/opt/bin/$(PKG_NAME)
endef

$(eval $(call BuildPackage,asciinema-ng))
