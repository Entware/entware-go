# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=v2ray
PKG_VERSION:=5.23.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-12-09
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/v2fly/v2ray-core
PKG_MIRROR_HASH:=2e0c35a05c59c58d1f8788badb2b30366cce3e0b03baca34599735c4c602e910

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/v2ray/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=proxy building platform
	URL:=https://www.v2fly.org
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/v2ray-core
	$(call Package/v2ray/Default)
	VARIANT:=hf
	EXTRA_DEPENDS:=ca-bundle, v2ray-geoip, v2ray-geosite
endef

define Package/v2ray-core_nohf
	$(call Package/v2ray/Default)
	VARIANT:=nohf
	DEPENDS:=@arm
	EXTRA_DEPENDS:=ca-bundle, v2ray-geoip, v2ray-geosite
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
