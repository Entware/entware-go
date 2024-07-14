#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy2
PKG_VERSION:=2.1.5
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=1b65fe62b01965bfee3f7ed8ba852c15de1255eb
PKG_SOURCE_URL:=https://github.com/DNSCrypt/dnscrypt-proxy
PKG_MIRROR_HASH:=1a1cd9b8fcdee47514c22e229812acbc8bfb635b094183d0e7799206df13be9d

PKG_BUILD_PARALLEL:=1

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
	DEPENDS+=@arm
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
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/dnscrypt-proxy $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S09dnscrypt-proxy2 $(1)/opt/etc/init.d
	$(INSTALL_CONF) \
		$(PKG_BUILD_DIR)/dnscrypt-proxy/example-dnscrypt-proxy.toml \
			$(1)/opt/etc/dnscrypt-proxy.toml
endef

Package/dnscrypt-proxy2_nohf/install=$(Package/dnscrypt-proxy2/install)

$(eval $(call BuildPackage,dnscrypt-proxy2))
$(eval $(call BuildPackage,dnscrypt-proxy2_nohf))
