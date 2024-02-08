#
# Copyright (C) 2011-2024 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sing-box-go
PKG_VERSION:=1.8.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=216a0380fe85a88ea1c423ade15145b38d7dbe89
PKG_SOURCE_URL:=https://github.com/SagerNet/sing-box
PKG_MIRROR_HASH:=skip

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/sing-box-go/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=VPN
	TITLE:=The universal proxy platform
	URL:=https://github.com/SagerNet/sing-box
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/sing-box-go
	$(call Package/sing-box-go/Default)
	VARIANT:=hf
endef

define Package/sing-box-go_nohf
	$(call Package/sing-box-go/Default)
	VARIANT:=nohf
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/sing-box-go/description
 Sing-box is a fast, customizable and univsersal proxy platform that can be used to create network proxy servers, clients and transparent proxies.
endef

Package/sing-box-go_nohf/description=$(Package/sing-box-go/description)

GO_LDFLAGS += \
	-X 'github.com/sagernet/sing-box/constant.Version=$(PKG_VERSION)'

GO_TARGET:=./cmd/sing-box

GO_TAGS:=-tags=with_gvisor,with_dhcp,with_wireguard,with_reality_server,with_clash_api,with_quic,with_ech,with_utls

define Package/sing-box-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/sing-box $(1)/opt/bin
endef

Package/sing-box-go_nohf/install=$(Package/sing-box-go/install)

$(eval $(call BuildPackage,sing-box-go))
$(eval $(call BuildPackage,sing-box-go_nohf))
