#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=nextdns
PKG_VERSION:=1.38.0
PKG_RELEASE:=1

PKG_GOGET:=github.com/nextdns/nextdns

PKG_SOURCE_VERSION:=d409692763b9b5408b28c21c1fa1e7d22581390d

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=9f2abe95e932fa99885736babc5a49c801a32b2748b63b3cb6b4429b8723aa61

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
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
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
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/nextdns $(1)/opt/bin
endef

Package/nextdns_nohf/install=$(Package/nextdns/install)

$(eval $(call BuildPackage,nextdns))
$(eval $(call BuildPackage,nextdns_nohf))
