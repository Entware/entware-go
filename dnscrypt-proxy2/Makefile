#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy2
PKG_VERSION:=2.1.4
PKG_RELEASE:=1

PKG_GOGET:=github.com/DNSCrypt/dnscrypt-proxy

PKG_SOURCE_VERSION:=9f3ef735f283a90d97b041a4d1d6bf8f866fe6ef

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=c63b5718eac43533f896ebf7f5a0617ae5770821dd493269b28fffda9efd49c2

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/dnscrypt-proxy2/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Flexible DNS proxy with encrypted DNS protocols
	URL:=https://github.com/DNSCrypt/dnscrypt-proxy
	MAINTAINER:=Entware team, https://entware.net
	DEPENDS:=+ca-bundle
endef

define Package/dnscrypt-proxy2
	$(call Package/dnscrypt-proxy2/Default)
	VARIANT:=hf
endef

define Package/dnscrypt-proxy2_nohf
	$(call Package/dnscrypt-proxy2/Default)
	VARIANT:=nohf
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/dnscrypt-proxy2/description
 A flexible DNS proxy, with support for modern encrypted DNS protocols
 such as DNSCrypt v2 and DNS-over-HTTP/2.
 DNSCrypt is a network protocol designed by Frank Denis and Yecheng Fu,
 which authenticates Domain Name System (DNS) traffic between the user's
 computer and recursive name servers.
endef

Package/dnscrypt-proxy2_nohf/description=$(Package/dnscrypt-proxy2/description)

define Package/dnscrypt-proxy2/conffiles
/opt/etc/dnscrypt-proxy.toml
endef

Package/dnscrypt-proxy2_nohf/conffiles=$(Package/dnscrypt-proxy2/conffiles)

GO_TARGET:=./dnscrypt-proxy

define Package/dnscrypt-proxy2/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/dnscrypt-proxy $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) files/S09dnscrypt-proxy2 $(1)/opt/etc/init.d
	$(INSTALL_CONF) \
		$(GO_SRC_DIR)/dnscrypt-proxy/example-dnscrypt-proxy.toml \
			$(1)/opt/etc/dnscrypt-proxy.toml
endef

Package/dnscrypt-proxy2_nohf/install=$(Package/dnscrypt-proxy2/install)

$(eval $(call BuildPackage,dnscrypt-proxy2))
$(eval $(call BuildPackage,dnscrypt-proxy2_nohf))
