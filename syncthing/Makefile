#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=syncthing
PKG_VERSION:=0.13.4
PKG_RELEASE:=1
PKG_GOGET:=github.com/syncthing/syncthing

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/syncthing
	$(call Package/gopackage/Default)
	TITLE:=Utility for synchronization of a folder between a number of collaborating devices.
	URL:=https://syncthing.net/
endef

define Package/syncthing/description
 Syncthing replaces proprietary sync and cloud services with something open, trustworthy and decentralized.
 Your data is your data alone and you deserve to choose where it is stored, if it is shared with some 
 third party and how it's transmitted over the Internet.
endef

# gccgo fails to build syncthing for GOARCH=386. So we use gc for it

ifeq ($(ARCH),i386)
  GO_COMPILE:=GOARCH=386 $(STAGING_DIR_HOST)/go/bin/go build -tags 'noupgrade' -o syncthing -x -v .
else
  GO_COMPILE:=gcc=$(TARGET_CC) ego build -tags 'noupgrade' -o syncthing -x -v -compiler gccgo -gccgoflags '$(TARGET_GCCGOFLAGS)' .
endif

ifeq ($(PKG_SOURCE),)
 define Build/Prepare
	$(INSTALL_DIR) $(PKG_BUILD_DIR)
	mkdir -p $(PKG_BUILD_DIR)/src/github.com/syncthing
	(	cd $(PKG_BUILD_DIR)/src/github.com/syncthing; \
		git clone https://github.com/syncthing/syncthing; \
		cd syncthing; \
		git checkout 9bb5988b4ed726a7eb7662dce01580b0e82dab02; \
	)
	$(Build/Patch)
	$(CP) $(PKG_BUILD_DIR)/src/github.com/syncthing/syncthing/vendor/* $(PKG_BUILD_DIR)/src/
	rm -rf $(PKG_BUILD_DIR)/src/github.com/golang/snappy/*
	$(CP) ./files/snappy/* $(PKG_BUILD_DIR)/src/github.com/golang/snappy/
 endef
endif

define Build/Compile
	( \
		cd $(PKG_BUILD_DIR)/src/github.com/syncthing/syncthing; \
		GOPATH=$(PKG_BUILD_DIR) PATH=$(GOROOT)/bin:$(TARGET_PATH) ./build.sh assets; \
		cd $(PKG_BUILD_DIR)/src/github.com/syncthing/syncthing/cmd/syncthing; \
		GOPATH=$(PKG_BUILD_DIR) $(GO_COMPILE) ; \
	)
endef

define Package/syncthing/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/github.com/syncthing/syncthing/cmd/syncthing/$(PKG_NAME) $(1)/opt/bin
endef

$(eval $(call BuildPackage,syncthing))
