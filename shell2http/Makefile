#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shell2http
PKG_VERSION:=go
PKG_RELEASE:=1
PKG_GOGET:=github.com/msoap/shell2http
#PKG_SOURCE=GOARCH-shell2http-2016-03-02.tar.bz2

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/shell2http
	SECTION:=Go
	CATEGORY:=Go
	DEPENDS:=+libgo +libpthread
	TITLE:=Execute shell commands via simple http server
	URL:=https://github.com/msoap/shell2http
	MAINTAINER:=Entware team, http://entware.net
endef

define Package/shell2http/description
 Executing shell commands via simple http server (written in Go language).
 Settings through 2 command line arguments, path and shell command. By default bind to :8080.
endef

define Package/shell2http/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/$(PKG_NAME) $(1)/opt/bin
endef

$(eval $(call BuildPackage,shell2http))
