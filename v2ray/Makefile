#
# Copyright (C) 2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=v2ray
PKG_VERSION:=5.7.0
PKG_RELEASE:=1
SOURCE_DATE:=2023-05-31

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=2ac0188d6f3072bb02de4432217b0e0077705b3d
PKG_SOURCE_URL:=https://github.com/v2fly/v2ray-core
PKG_MIRROR_HASH:=3c8705a6ac5d194ca0b604394ba3f1706b622b062246a77ec2b4ed80fa3f4c12

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/v2ray/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=proxy building platform
	URL:=https://github.com/v2fly/v2ray-core
	MAINTAINER:=Entware team, https://entware.net
	DEPENDS:=+ca-bundle
endef

define Package/v2ray
	$(call Package/v2ray/Default)
	VARIANT:=hf
endef

define Package/v2ray_nohf
	$(call Package/v2ray/Default)
	VARIANT:=nohf
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/v2ray/description
 A platform for building proxies to bypass network restrictions.
endef

Package/v2ray_nohf/description=$(Package/v2ray/description)

define Package/v2ray/conffiles
/opt/etc/v2ray/config.json
/opt/etc/v2ray/vpoint_socks_vmess.json
/opt/etc/v2ray/vpoint_vmess_freedom.json
endef

Package/v2ray_nohf/conffiles=$(Package/v2ray/conffiles)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/v5.codename=Entware' \
	-X '$(XIMPORTPATH)/v5.build=$(SOURCE_DATE)' \
	-X '$(XIMPORTPATH)/v5.version=$(PKG_VERSION)'

GO_TARGET:=./main

GO_VARS += GO111MODULE=on

define Package/v2ray/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/main $(1)/opt/sbin/v2ray
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S24v2ray $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/v2ray
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/release/config/*.json $(1)/opt/etc/v2ray
endef

Package/v2ray_nohf/install=$(Package/v2ray/install)

$(eval $(call BuildPackage,v2ray))
$(eval $(call BuildPackage,v2ray_nohf))
