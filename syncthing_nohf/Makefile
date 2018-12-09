#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=syncthing_nohf
PKG_VERSION:=0.14.54
PKG_RELEASE:=1
PKG_GOGET:=github.com/syncthing/syncthing

GOPKG_SOURCE=GO_syncthing-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=da39dfada33fe152c1d2297ff69dbf0739564516

#do not build both packages in parallel
PKG_BUILD_DEPENDS:=syncthing

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/syncthing_nohf
	$(call Package/gopackage/Default)
	DEPENDS:=@TARGET_armv7_3_2||@TARGET_armv7_2_6
	TITLE:=Utility for synchronization of a folder between a number of collaborating devices (arm version with no hard float)
	URL:=https://syncthing.net/
endef

define Package/syncthing_nohf/description
 Syncthing replaces proprietary sync and cloud services with something open, trustworthy and decentralized.
 Your data is your data alone and you deserve to choose where it is stored, if it is shared with some 
 third party and how it's transmitted over the Internet.
endef

define Build/Compile
	( \
		cd $(PKG_BUILD_DIR); \
		mkdir -p bin; \
		cd src/$(PKG_GOGET); \
		PATH="$(GOROOT)/bin:$$$$PATH" \
		GOPATH=$(PKG_BUILD_DIR) GOARM=5 go run build.go -goos linux -goarch $(GOARCH) -version v$(PKG_VERSION) -no-upgrade build ; \
	)
endef


define Package/syncthing_nohf/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/github.com/syncthing/syncthing/syncthing $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) files/S92syncthing $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,syncthing_nohf))
