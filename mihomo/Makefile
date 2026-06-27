# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=mihomo
PKG_VERSION:=1.19.27
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/MetaCubeX/mihomo
PKG_MIRROR_HASH:=874e0c44d72d5c017b3e6904542502b7645bdc7fb55a924b2ee608d9e52268d8

PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/mihomo/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=Mihomo (MetaCubeX) universal proxy
  URL:=https://wiki.metacubex.one
  EXTRA_DEPENDS:=ca-bundle
endef

define Package/mihomo
  $(call Package/mihomo/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/mihomo_nohf
  $(call Package/mihomo/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/mihomo/description
  Mihomo is a rule-based tunnel that supports multiple protocols, including
  HTTP, HTTPS, SOCKS5, Shadowsocks, VMess and so on.
endef

Package/mihomo_nohf/description=$(Package/mihomo/description)

define Package/mihomo/conffiles
/opt/etc/mihomo/config.yaml
endef

Package/mihomo_nohf/conffiles=$(Package/mihomo/conffiles)

XIMPORTPATH:=$(call tolower,$(XIMPORTPATH))

GO_LDFLAGS += \
  -X '$(XIMPORTPATH)/constant.Version=$(PKG_VERSION)' \
  -X '$(XIMPORTPATH)/constant.BuildTime=$(shell date -u +%Y-%m-%dT%H:%M:%SZ --date=@$(SOURCE_DATE_EPOCH))'

GO_TARGET:=./
GO_TAGS:=with_gvisor

define Package/mihomo/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/mihomo $(1)/opt/bin/mihomo
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99mihomo $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/mihomo
	$(INSTALL_CONF) ./files/config.yaml $(1)/opt/etc/mihomo
endef

Package/mihomo_nohf/install=$(Package/mihomo/install)

$(eval $(call BuildPackage,mihomo))
$(eval $(call BuildPackage,mihomo_nohf))
