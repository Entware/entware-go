#
# Copyright (C) 2011-2018 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy2
PKG_VERSION:=2.0.8
PKG_RELEASE:=1
PKG_GOGET:=github.com/jedisct1/dnscrypt-proxy

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=5cc4663081027a56c40ffae233c4b9b61009df60

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/dnscrypt-proxy2
	$(call Package/gopackage/Default)
	TITLE:=A flexible DNS proxy, with support for modern encrypted DNS protocols such as DNSCrypt v2 and DNS-over-HTTP/2
	URL:=https://github.com/jedisct1/dnscrypt-proxy
endef

define Package/dnscrypt-proxy2/description
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


define Package/dnscrypt-proxy2/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/$(PKG_GOGET)/dnscrypt-proxy/dnscrypt-proxy $(1)/opt/bin
endef

$(eval $(call BuildPackage,dnscrypt-proxy2))
