#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=lux
PKG_VERSION:=0.15.0
PKG_RELEASE:=1
PKG_GOGET:=github.com/iawia002/lux

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE:=$(GOPKG_SOURCE)
PKG_HASH:=5225acfb3893aedb90a991053bdce305f5f2d08ef12a2d87aa2b1dddd3ca5fb0
PKG_COMMIT:=adc5257b318232f134a8ecdaf28884b95a0a6b28

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/lux/Default
	$(call Package/gopackage/Default)
	DEPENDS:=+ffmpeg
	TITLE:=lux is a fast, simple and clean video downloader built with Go
	URL:=https://github.com/iawia002/lux
endef

define Package/lux
	$(call Package/lux/Default)
	VARIANT:=hf
endef

define Package/lux_nohf
	$(call Package/lux/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/lux/description
 A fast, simple and clean video downloader (command line)
endef

Package/lux_nohf/description=$(Package/lux/description)

define Build/Compile
        (\
                cd $(PKG_BUILD_DIR); \
		mkdir -p bin; \
		cd src/$(PKG_GOGET); \
		CGO_ENABLED=0 GO111MODULE=on GOOS=linux GOARCH=$(GOARCH) $(GOARM) GOPATH=$(PKG_BUILD_DIR) $(GOROOT)/bin/go build -ldflags="-s -w" -x -v; \
		cp lux $(PKG_BUILD_DIR)/bin; \
		chmod -R +w $(PKG_BUILD_DIR)/pkg; \
        )
endef


define Package/lux/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/lux $(1)/opt/bin
endef

Package/lux_nohf/install=$(Package/lux/install)

$(eval $(call BuildPackage,lux))
$(eval $(call BuildPackage,lux_nohf))

