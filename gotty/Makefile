#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=gotty
PKG_VERSION:=2016-03-02
PKG_RELEASE:=1
PKG_GOGET:=github.com/yudai/gotty

GOARCH=GOARCH_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
#PKG_SOURCE=$(GOARCH)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/gotty
	$(call Package/gopackage/Default)
	TITLE:=GoTTY is a simple command line tool that turns your CLI tools into web applications.
	URL:=https://github.com/yudai/gotty
endef

define Package/gotty/description
 GoTTY - Share your terminal as a web application.
endef

# Use go get only when PKG_SOURCE is undefined!!!
ifeq ($(PKG_SOURCE),)
 define Build/Prepare
	$(INSTALL_DIR) $(PKG_BUILD_DIR)
	GOPATH=$(PKG_BUILD_DIR) gcc=$(TARGET_CC) ego get -d -x $(PKG_GOGET)
	GOPATH=$(PKG_BUILD_DIR) gcc=$(TARGET_CC) ego get -d -x github.com/jteeuwen/go-bindata
	(cd $(PKG_BUILD_DIR)/src/$(PKG_GOGET); \
		git submodule sync && git submodule update --init --recursive; \
		GOPATH=$(PKG_BUILD_DIR) PATH=$(GOROOT)/bin:$(TARGET_PATH) godep restore \
	)
 endef
endif


define Package/gotty/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/$(PKG_NAME) $(1)/opt/bin
endef

$(eval $(call BuildPackage,gotty))
