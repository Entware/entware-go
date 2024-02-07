# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=v2ray
PKG_VERSION:=5.13.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2023-12-11
PKG_SOURCE_VERSION:=458db3954f76bbf7ce621a24151d9d5469d8b6fb
PKG_SOURCE_URL:=https://github.com/v2fly/v2ray-core
PKG_MIRROR_HASH:=b8eca83ffe4c5bc17275c12c4d7a1350c5f6abcd46b69e7846d72520e3817d5e

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

define Package/v2ray-core
	$(call Package/v2ray/Default)
	VARIANT:=hf
endef

define Package/v2ray-core_nohf
	$(call Package/v2ray/Default)
	VARIANT:=nohf
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/v2ray
	$(call Package/v2ray/Default)
	TITLE+= (scripts & configs)
	VARIANT:=hf
	DEPENDS:=+v2ray-core
endef

define Package/v2ray_nohf
	$(call Package/v2ray/Default)
	TITLE+= (scripts & configs)
	VARIANT:=nohf
	DEPENDS:=+v2ray-core_nohf
endef

define Package/v2ray-core/description
 A platform for building proxies to bypass network restrictions.
endef

Package/v2ray-core_nohf/description=$(Package/v2ray-core/description)

define Package/v2ray/description
 scripts & configs.
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
	-X '$(XIMPORTPATH)/v5.build=$(PKG_SOURCE_DATE)' \
	-X '$(XIMPORTPATH)/v5.version=$(PKG_VERSION)'

GO_TARGET:=./main

GO_VARS += GO111MODULE=on

define Package/v2ray-core/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/main $(1)/opt/sbin/v2ray
endef

Package/v2ray-core_nohf/install=$(Package/v2ray-core/install)

define Package/v2ray/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S24v2ray $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/v2ray
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/release/config/*.json $(1)/opt/etc/v2ray
endef

Package/v2ray_nohf/install=$(Package/v2ray/install)

$(eval $(call BuildPackage,v2ray-core))
$(eval $(call BuildPackage,v2ray-core_nohf))
$(eval $(call BuildPackage,v2ray))
$(eval $(call BuildPackage,v2ray_nohf))
