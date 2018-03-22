#
# Copyright (C) 2011-2018 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy2
PKG_VERSION:=2.0.4
PKG_RELEASE:=1
PKG_GOGET:=github.com/jedisct1/dnscrypt-proxy

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=6000f5073a7c4c365556dbf4535a7f427017814a

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

GOARM=GOARM=5

define Package/dnscrypt-proxy2_nohf
	$(call Package/gopackage/Default)
	DEPENDS:=@TARGET_armv7_3_2||@TARGET_armv7_2_6
	TITLE:=A flexible DNS proxy, with support for modern encrypted DNS protocols such as DNSCrypt v2 and DNS-over-HTTP/2 (arm version with no hard float)
	URL:=https://github.com/jedisct1/dnscrypt-proxy
endef

define Package/dnscrypt-proxy2_nohf/description
 DNSCrypt is a network protocol designed by Frank Denis and Yecheng Fu,
 which authenticates Domain Name System (DNS) traffic between the user's computer and recursive name servers
endef

define Build/Compile
	(\
		cd $(PKG_BUILD_DIR); \
		cd src/$(PKG_GOGET)/dnscrypt-proxy; \
		GOOS=linux GOARCH=$(GOARCH) $(GOARM) GOPATH=$(PKG_BUILD_DIR) $(GOROOT)/bin/go build -ldflags="-s -w" -x -v $(PKG_GOGET)/dnscrypt-proxy; \
	)
endef


define Package/dnscrypt-proxy2_nohf/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/$(PKG_GOGET)/dnscrypt-proxy/dnscrypt-proxy $(1)/opt/bin
endef

$(eval $(call BuildPackage,dnscrypt-proxy2_nohf))
