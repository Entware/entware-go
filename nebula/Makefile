#
# Copyright (C) 2011-2019 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=nebula
PKG_VERSION:=1.3.0
PKG_RELEASE:=1
PKG_GOGET:=github.com/slackhq/nebula

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=c71c84882eab6dfca63a9e2b9e346c545f81a55d

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/nebula/Default
	$(call Package/gopackage/Default)
	TITLE:=Nebula is a scalable overlay networking tool 
	URL:=https://github.com/slackhq/nebula
endef

define Package/nebula
	$(call Package/nebula/Default)
	VARIANT:=hf
endef

define Package/nebula_nohf
	$(call Package/nebula/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/nebula/description
 Nebula is a scalable overlay networking tool with a focus on performance, simplicity and security.
 It lets you seamlessly connect computers anywhere in the world. Nebula is portable, and runs on Linux, OSX, and Windows.
 It can be used to connect a small number of computers, but is also able to connect tens of thousands of computers.
endef

Package/nebula_nohf/description=$(Package/nebula/description)

define Build/Compile
        (\
                cd $(PKG_BUILD_DIR); \
		mkdir -p bin; \
		cd src/$(PKG_GOGET); \
		CGO_ENABLED=0 GO111MODULE=on GOOS=linux GOARCH=$(GOARCH) $(GOARM) GOPATH=$(PKG_BUILD_DIR) $(GOROOT)/bin/go build -ldflags="-X main.Build=$(PKG_VERSION) -s -w" -x -v $(PKG_GOGET)/cmd/nebula; \
		cp nebula $(PKG_BUILD_DIR)/bin; \
		CGO_ENABLED=0 GO111MODULE=on GOOS=linux GOARCH=$(GOARCH) $(GOARM) GOPATH=$(PKG_BUILD_DIR) $(GOROOT)/bin/go build -ldflags="-X main.Build=$(PKG_VERSION) -s -w" -x -v $(PKG_GOGET)/cmd/nebula-cert; \
		cp nebula-cert $(PKG_BUILD_DIR)/bin; \
		chmod -R +w $(PKG_BUILD_DIR)/pkg; \
        )
endef


define Package/nebula/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nebula $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nebula-cert $(1)/opt/bin
endef

Package/nebula_nohf/install=$(Package/nebula/install)

$(eval $(call BuildPackage,nebula))
$(eval $(call BuildPackage,nebula_nohf))

