#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=syncthing
PKG_VERSION:=0.14.54
PKG_RELEASE:=1
PKG_GOGET:=github.com/syncthing/syncthing

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=da39dfada33fe152c1d2297ff69dbf0739564516

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/syncthing/Default
	$(call Package/gopackage/Default)
	TITLE:=Utility for synchronization of a folder between a number of collaborating devices.
	URL:=https://syncthing.net/
endef

define Package/syncthing
	$(call Package/syncthing/Default)
	VARIANT:=hf
endef

define Package/syncthing_nohf
	$(call Package/syncthing/Default)
	VARIANT:=nohf
	DEPENDS:=@TARGET_armv7_3_2||@TARGET_armv7_2_6
endef

define Package/syncthing/description
 Syncthing replaces proprietary sync and cloud services with something open, trustworthy and decentralized.
 Your data is your data alone and you deserve to choose where it is stored, if it is shared with some 
 third party and how it's transmitted over the Internet.
endef

Package/syncthing_nohf/description=$(Package/syncthing/description)

define Build/Compile
	( \
		cd $(PKG_BUILD_DIR); \
		mkdir -p bin; \
		cd src/$(PKG_GOGET); \
		PATH="$(GOROOT)/bin:$$$$PATH" \
		GOPATH=$(PKG_BUILD_DIR) $(GOARM) go run build.go -goos linux -goarch $(GOARCH) -version v$(PKG_VERSION) -no-upgrade build ; \
	)
endef


define Package/syncthing/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/github.com/syncthing/syncthing/$(PKG_NAME) $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) files/S92syncthing $(1)/opt/etc/init.d
endef

Package/syncthing_nohf/install=$(Package/syncthing/install)

$(eval $(call BuildPackage,syncthing))
$(eval $(call BuildPackage,syncthing_nohf))
