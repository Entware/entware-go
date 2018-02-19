#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=shell2http_nohf
PKG_VERSION:=2017-04-08
PKG_RELEASE:=1
PKG_GOGET:=github.com/msoap/shell2http

GOPKG_SOURCE=GO_shell2http-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)

#do not build both packages in parallel
PKG_BUILD_DEPENDS:=shell2http

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

GOARM=GOARM=5

define Package/shell2http_nohf
	$(call Package/gopackage/Default)
	DEPENDS:=@TARGET_armv7_3x||@TARGET_armv7soft
	TITLE:=Execute shell commands via simple http server (arm version with no hard float)
	URL:=https://github.com/msoap/shell2http
endef

define Package/shell2http_nohf/description
 Executing shell commands via simple http server (written in Go language).
 Settings through 2 command line arguments, path and shell command. By default bind to :8080.
endef

define Package/shell2http_nohf/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/shell2http $(1)/opt/bin
endef

$(eval $(call BuildPackage,shell2http_nohf))
