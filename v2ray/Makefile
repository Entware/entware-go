#
# Copyright (C) 2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=v2ray
PKG_VERSION:=5.1.0
PKG_RELEASE:=1

PKG_GOGET:=github.com/v2fly/v2ray-core

PKG_SOURCE_VERSION:=6fcdf998f1983708e3c73c66d11644bc33faeaa0

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=ffcc416934d5f2d03eb96a70d0e06600c008ab826a05c513e46cba357376363f

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
	-X '$(PKG_GOGET)/v5.codename=Entware' \
	-X '$(PKG_GOGET)/v5.build=$(SOURCE_DATE_EPOCH)' \
	-X '$(PKG_GOGET)/v5.version=$(PKG_VERSION)'

GO_TARGET:=./main

GO_VARS += GO111MODULE=on

define Package/v2ray/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/main $(1)/opt/sbin/v2ray
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) files/S24v2ray $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/v2ray
	$(INSTALL_CONF) $(GO_SRC_DIR)/release/config/*.json $(1)/opt/etc/v2ray
endef

Package/v2ray_nohf/install=$(Package/v2ray/install)

$(eval $(call BuildPackage,v2ray))
$(eval $(call BuildPackage,v2ray_nohf))
