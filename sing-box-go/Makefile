#
# Copyright (C) 2011-2024 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=sing-box-go
PKG_VERSION:=1.9.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=085f60337799afc906069b540a38368968c123e4
PKG_SOURCE_URL:=https://github.com/SagerNet/sing-box
PKG_MIRROR_HASH:=9c35038f5be6fcb99f4412d90008b0457f92a0ff21398a5774a0625ac2e8c82a

PKG_BUILD_PARALLEL:=1

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
	DEPENDS+=@arm
endef

define Package/sing-box-go/description
 Sing-box is a fast, customizable and univsersal proxy platform that
can be used to create network proxy servers, clients and transparent proxies.
endef

Package/sing-box-go_nohf/description=$(Package/sing-box-go/description)

define Package/sing-box-go/conffiles
/opt/etc/sing-box/config.json
endef

Package/sing-box-go_nohf/conffiles=$(Package/sing-box-go/conffiles)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/constant.Version=$(PKG_VERSION)'

GO_TARGET:=./cmd/sing-box

GO_TAGS:= \
	with_clash_api, \
	with_dhcp, \
	with_ech, \
	with_gvisor, \
	with_quic, \
	with_reality_server, \
	with_utls, \
	with_wireguard

define Package/sing-box-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/sing-box $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/sing-box
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/release/config/config.json $(1)/opt/etc/sing-box
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99sing-box $(1)/opt/etc/init.d
endef

Package/sing-box-go_nohf/install=$(Package/sing-box-go/install)

$(eval $(call BuildPackage,sing-box-go))
$(eval $(call BuildPackage,sing-box-go_nohf))
