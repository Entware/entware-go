# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=v2ray-plugin
PKG_VERSION:=5.17.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/teddysun/v2ray-plugin
PKG_MIRROR_HASH:=17dc80f719d00dfd7326f9a6f1de5d884e94c520dc3802d4cdbad88680995ee5

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/v2ray-plugin/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=A SIP003 plugin based on v2ray
  URL:=https://github.com/teddysun/v2ray-plugin
endef

define Package/v2ray-plugin
  $(call Package/v2ray-plugin/Default)
  VARIANT:=hf
endef

define Package/v2ray-plugin_nohf
  $(call Package/v2ray-plugin/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/v2ray-plugin/description
  Yet another SIP003 plugin for shadowsocks, based on v2ray.
endef

Package/v2ray-plugin_nohf/description=$(Package/v2ray-plugin/description)

GO_LDFLAGS += -X 'main.VERSION=v$(PKG_VERSION)'

define Package/v2ray-plugin/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/v2ray-plugin $(1)/opt/bin
endef

Package/v2ray-plugin_nohf/install=$(Package/v2ray-plugin/install)

$(eval $(call BuildPackage,v2ray-plugin))
$(eval $(call BuildPackage,v2ray-plugin_nohf))
