# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2020-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=nextdns
PKG_VERSION:=1.43.5
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=e051fcc9dfb2b332bb25a11447b6b158ae9a6b78
PKG_SOURCE_URL:=https://github.com/nextdns/nextdns
PKG_MIRROR_HASH:=39ff3c9c253e4d1a9ce2896c786f1695e825c8af8b70d33e9328511b8e0efd38

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/nextdns/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=IP Addresses and Names
	TITLE:=NextDNS CLI Client
	URL:=https://github.com/nextdns/nextdns
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/nextdns
	$(call Package/nextdns/Default)
	VARIANT:=hf
endef

define Package/nextdns_nohf
	$(call Package/nextdns/Default)
	VARIANT:=nohf
	DEPENDS:=@arm
endef

define Package/nextdns/description
 NextDNS CLI is a DNS53 to DNS-over-HTTPS (DoH) proxy with
 advanced capabilities to get the most out of the NextDNS
 service. Although the most advanced features will only work
 with NextDNS, this program can work as a client for any DoH
 provider or a mix of NextDNS + another DNS (split horizon).
endef

Package/nextdns_nohf/description=$(Package/nextdns/description)

GO_LDFLAGS += \
	-X 'main.Build=v$(PKG_VERSION)'

GO_VARS += GO111MODULE=on

define Package/nextdns/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/nextdns $(1)/opt/bin
endef

Package/nextdns_nohf/install=$(Package/nextdns/install)

$(eval $(call BuildPackage,nextdns))
$(eval $(call BuildPackage,nextdns_nohf))
