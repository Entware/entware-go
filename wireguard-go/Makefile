#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=wireguard-go
PKG_VERSION:=v0.0.20220316
PKG_RELEASE:=1
PKG_GOGET:=git.zx2c4.com/wireguard-go

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE:=$(GOPKG_SOURCE)
PKG_HASH:=769ed4ca973c9b8bba5eeb45c1aeda85b86f1a6b05b78897a28d685818e8f9ab
PKG_COMMIT:=b7826f8c8cadeabcfe34542ce5ad5d3701be21d1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/wireguard-go/Default
	$(call Package/gopackage/Default)
	TITLE:=This is an implementation of WireGuard in Go
	URL:=https://git.zx2c4.com/wireguard-go/about/
	DEPENDS:=+wireguard-tools +wg-quick @!LINUX_2_6_36
endef

define Package/wireguard-go
	$(call Package/wireguard-go/Default)
	VARIANT:=hf
endef

define Package/wireguard-go_nohf
	$(call Package/wireguard-go/Default)
	VARIANT:=nohf
	DEPENDS:=@TARGET_armv7_3_2
endef

define Package/wireguard-go/description
 This is an implementation of WireGuard in Go
endef

Package/wireguard-go_nohf/description=$(Package/wireguard-go/description)

define Build/Compile
        (\
                cd $(PKG_BUILD_DIR); \
		mkdir -p bin; \
		cd src/$(PKG_GOGET); \
		PATH="$(TARGET_PATH):$(GOROOT)/bin" CGO_ENABLED=0 GOOS=linux GOARCH=$(GOARCH) $(GOARM) GOPATH=$(PKG_BUILD_DIR) make; \
		chmod -R +w $(PKG_BUILD_DIR)/pkg; \
        )
endef


define Package/wireguard-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/$(PKG_GOGET)/wireguard-go $(1)/opt/bin
endef

Package/wireguard-go_nohf/install=$(Package/wireguard-go/install)

$(eval $(call BuildPackage,wireguard-go))
$(eval $(call BuildPackage,wireguard-go_nohf))

