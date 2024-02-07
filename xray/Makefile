# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=xray
PKG_VERSION:=1.8.7
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=3f0bc134298cf512bd29660221a030db91594faf
PKG_SOURCE_URL:=https://github.com/XTLS/Xray-core
PKG_MIRROR_HASH:=29215def0f50ba8dab38a3865b1994f36f327835dfa44bd8da419451d321d089

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/xray/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=a personal vpn server
	URL:=https://github.com/XTLS/Xray-core
	MAINTAINER:=Entware team, https://entware.net
	DEPENDS:=+ca-bundle
endef

define Package/xray-core
	$(call Package/xray/Default)
	VARIANT:=hf
endef

define Package/xray-core_nohf
	$(call Package/xray/Default)
	VARIANT:=nohf
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/xray
	$(call Package/xray/Default)
	TITLE+= (scripts & configs)
	VARIANT:=hf
	DEPENDS:=+xray-core
endef

define Package/xray_nohf
	$(call Package/xray/Default)
	TITLE+= (scripts & configs)
	VARIANT:=nohf
	DEPENDS:=+xray-core_nohf
endef

define Package/xray-core/description
 Project X originates from XTLS protocol, providing a set of network tools.
endef

Package/xray-core_nohf/description=$(Package/xray-core/description)

define Package/xray/description
 scripts & configs.
endef

Package/xray_nohf/description=$(Package/xray/description)

define Package/xray/conffiles
/opt/etc/xray/config.json
endef

Package/xray_nohf/conffiles=$(Package/xray/conffiles)

GO_LDFLAGS += -buildid=

GO_BUILD_ARGS += -a

GO_TARGET:=./main

define Package/xray-core/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/main $(1)/opt/sbin/xray
endef

Package/xray-core_nohf/install=$(Package/xray-core/install)

define Package/xray/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S24xray $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/xray
	$(INSTALL_CONF) ./files/config.json.example $(1)/opt/etc/xray
endef

Package/xray_nohf/install=$(Package/xray/install)

$(eval $(call BuildPackage,xray-core))
$(eval $(call BuildPackage,xray-core_nohf))
$(eval $(call BuildPackage,xray))
$(eval $(call BuildPackage,xray_nohf))
