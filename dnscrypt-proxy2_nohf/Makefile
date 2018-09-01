#
# Copyright (C) 2011-2018 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy2_nohf
PKG_VERSION:=2.0.16
PKG_RELEASE:=1
PKG_GOGET:=github.com/jedisct1/dnscrypt-proxy

GOPKG_SOURCE=GO_dnscrypt-proxy2-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=a63da435aeb5d950d57433c511f948188b9aa5de

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

GOARM=GOARM=5

define Package/dnscrypt-proxy2_nohf
	$(call Package/gopackage/Default)
	DEPENDS:=@TARGET_armv7_3_2||@TARGET_armv7_2_6 +ca-bundle
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

define Package/dnscrypt-proxy2_nohf/conffiles
/opt/etc/dnscrypt-proxy.toml
endef

define Package/dnscrypt-proxy2_nohf/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/$(PKG_GOGET)/dnscrypt-proxy/dnscrypt-proxy $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) files/S09dnscrypt-proxy2 $(1)/opt/etc/init.d
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/src/$(PKG_GOGET)/dnscrypt-proxy/example-dnscrypt-proxy.toml $(1)/opt/etc/dnscrypt-proxy.toml
endef

$(eval $(call BuildPackage,dnscrypt-proxy2_nohf))
