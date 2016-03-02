#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gotty
PKG_VERSION:=go
PKG_RELEASE:=1
PKG_GOGET:=github.com/yudai/gotty

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/gotty
	SECTION:=Go
	CATEGORY:=Go
	DEPENDS:=+libgo +libpthread
	TITLE:=GoTTY is a simple command line tool that turns your CLI tools into web applications.
	URL:=https://github.com/yudai/gotty
	MAINTAINER:=Entware team, http://entware.net
endef

define Package/gotty/description
 GoTTY - Share your terminal as a web application.
endef

define Build/Prepare
	$(INSTALL_DIR) $(PKG_BUILD_DIR)
	GOPATH=$(PKG_BUILD_DIR) gcc=$(TARGET_CC) ego get -d -x $(PKG_GOGET)
	GOPATH=$(PKG_BUILD_DIR) gcc=$(TARGET_CC) ego get -d -x github.com/jteeuwen/go-bindata
	(cd $(PKG_BUILD_DIR)/src/$(PKG_GOGET); \
		git submodule sync && git submodule update --init --recursive; \
		GOPATH=$(PKG_BUILD_DIR) PATH=$(GOROOT)/bin:$(TARGET_PATH) godep restore \
	)
endef


define Package/gotty/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/$(PKG_NAME) $(1)/opt/bin
endef

$(eval $(call BuildPackage,gotty))
