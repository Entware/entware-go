# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2011-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=dnscrypt-proxy2
PKG_VERSION:=2.1.15
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/DNSCrypt/dnscrypt-proxy
PKG_MIRROR_HASH:=90dfee3884e69f36b2de01a66cb63f4d9accfe39097688ca7864f6fe9f8cb4ee

PKG_LICENSE:=ISC
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/dnscrypt-proxy2/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=Flexible DNS proxy with encrypted DNS protocols
  URL:=https://dnscrypt.info/
  PROVIDES:=dnscrypt-proxy2
  CONFLICTS:=dnscrypt-proxy
  EXTRA_DEPENDS:=ca-bundle
endef

define Package/dnscrypt-proxy2
  $(call Package/dnscrypt-proxy2/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/dnscrypt-proxy2_nohf
  $(call Package/dnscrypt-proxy2/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
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

GO_BUILD_ARGS:= -mod vendor
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
