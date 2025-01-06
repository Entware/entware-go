# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=xray-plugin
PKG_VERSION:=1.8.24
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/teddysun/xray-plugin
PKG_MIRROR_HASH:=8f3818a5de82e1a3b439c991ae6816f84f1ccabd2f8404bc4cf6fe021a8d1e7a

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/xray-plugin/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=A SIP003 plugin based on Xray-core
  URL:=https://github.com/teddysun/xray-plugin
endef

define Package/xray-plugin
  $(call Package/xray-plugin/Default)
  VARIANT:=hf
endef

define Package/xray-plugin_nohf
  $(call Package/xray-plugin/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/xray-plugin/description
  Yet another SIP003 plugin for shadowsocks, based on Xray-core.
endef

Package/xray-plugin_nohf/description=$(Package/xray-plugin/description)

GO_LDFLAGS += -X 'main.VERSION=v$(PKG_VERSION)'

define Package/xray-plugin/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/xray-plugin $(1)/opt/bin
endef

Package/xray-plugin_nohf/install=$(Package/xray-plugin/install)

$(eval $(call BuildPackage,xray-plugin))
$(eval $(call BuildPackage,xray-plugin_nohf))
