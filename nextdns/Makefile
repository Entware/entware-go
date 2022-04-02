#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=nextdns
PKG_VERSION:=v1.37.10
PKG_RELEASE:=1
PKG_GOGET:=github.com/nextdns/nextdns

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE:=$(GOPKG_SOURCE)
PKG_HASH:=0dc7945af1840a9c38de0d3886c9f7a58c083982f5c8d5f5a88426120c996574
PKG_COMMIT:=3e26ffdd37f9a177d0b469d4507510406375214e

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/nextdns/Default
	$(call Package/gopackage/Default)
	TITLE:=NextDNS CLI Client
	URL:=https://github.com/nextdns/nextdns
endef

define Package/nextdns
	$(call Package/nextdns/Default)
	VARIANT:=hf
endef

define Package/nextdns_nohf
	$(call Package/nextdns/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/nextdns/description
 NextDNS CLI is a DNS53 to DNS-over-HTTPS (DoH) proxy with advanced capabilities to get the most out of the NextDNS service.
 Although the most advanced features will only work with NextDNS, this program can work as a client for any DoH provider or
 a mix of NextDNS + another DNS (split horizon).
endef

Package/nextdns_nohf/description=$(Package/nextdns/description)

define Build/Compile
        (\
                cd $(PKG_BUILD_DIR); \
		mkdir -p bin; \
		cd src/$(PKG_GOGET); \
		CGO_ENABLED=0 GO111MODULE=on GOOS=linux GOARCH=$(GOARCH) $(GOARM) GOPATH=$(PKG_BUILD_DIR) $(GOROOT)/bin/go build -ldflags="-s -w" -x -v; \
		cp nextdns $(PKG_BUILD_DIR)/bin; \
		chmod -R +w $(PKG_BUILD_DIR)/pkg; \
        )
endef


define Package/nextdns/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nextdns $(1)/opt/bin
endef

Package/nextdns_nohf/install=$(Package/nextdns/install)

$(eval $(call BuildPackage,nextdns))
$(eval $(call BuildPackage,nextdns_nohf))

