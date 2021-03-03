#
# Copyright (C) 2011-2019 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=annie
PKG_VERSION:=0.10.3
PKG_RELEASE:=1
PKG_GOGET:=github.com/iawia002/annie

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=44319a9058d98ca56b5756538ba55ddd99e4e939

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/annie/Default
	$(call Package/gopackage/Default)
	TITLE:=annie is a fast, simple and clean video downloader built with Go
	URL:=https://github.com/iawia002/annie
endef

define Package/annie
	$(call Package/annie/Default)
	VARIANT:=hf
endef

define Package/annie_nohf
	$(call Package/annie/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/annie/description
 A fast, simple and clean video downloader (command line)
endef

Package/annie_nohf/description=$(Package/annie/description)

define Build/Compile
        (\
                cd $(PKG_BUILD_DIR); \
		mkdir -p bin; \
		cd src/$(PKG_GOGET); \
		CGO_ENABLED=0 GO111MODULE=on GOOS=linux GOARCH=$(GOARCH) $(GOARM) GOPATH=$(PKG_BUILD_DIR) $(GOROOT)/bin/go build -ldflags="-s -w" -x -v; \
		cp annie $(PKG_BUILD_DIR)/bin; \
		chmod -R +w $(PKG_BUILD_DIR)/pkg; \
        )
endef


define Package/annie/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/annie $(1)/opt/bin
endef

Package/annie_nohf/install=$(Package/annie/install)

$(eval $(call BuildPackage,annie))
$(eval $(call BuildPackage,annie_nohf))

