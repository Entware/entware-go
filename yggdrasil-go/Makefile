#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=yggdrasil-go
PKG_VERSION:=0.3.16
PKG_RELEASE:=1
PKG_GOGET:=github.com/yggdrasil-network/yggdrasil-go

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE:=$(GOPKG_SOURCE)
PKG_HASH:=42004e462d8f8d6cb11af7fda7675e818a52f27efc325e2f140e883647a8b65c
PKG_COMMIT:=983dfdb5535124cf2663166db580387d7a8a149d

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/yggdrasil-go/Default
	$(call Package/gopackage/Default)
	TITLE:=Encrypted IPv6 network
	URL:=https://yggdrasil-network.github.io/
endef

define Package/yggdrasil-go
	$(call Package/yggdrasil-go/Default)
	VARIANT:=hf
endef

define Package/yggdrasil-go_nohf
	$(call Package/yggdrasil-go/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/yggdrasil-go/description
 Yggdrasil is an early-stage implementation of a fully end-to-end encrypted IPv6 network.
endef

Package/yggdrasil-go_nohf/description=$(Package/yggdrasil-go/description)

define Build/Compile
        (\
                cd $(PKG_BUILD_DIR); \
		mkdir -p bin; \
		cd src/$(PKG_GOGET); \
		PATH="$(TARGET_PATH):$(GOROOT)/bin" CGO_ENABLED=0 GOOS=linux GOARCH=$(GOARCH) $(GOARM) GOPATH=$(PKG_BUILD_DIR) ./build; \
		chmod -R +w $(PKG_BUILD_DIR)/pkg; \
        )
endef

define Package/yggdrasil-go/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/$(PKG_GOGET)/yggdrasil $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/$(PKG_GOGET)/yggdrasilctl $(1)/opt/sbin
endef

Package/yggdrasil-go_nohf/install=$(Package/yggdrasil-go/install)

$(eval $(call BuildPackage,yggdrasil-go))
$(eval $(call BuildPackage,yggdrasil-go_nohf))

