# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=xray
PKG_VERSION:=26.10.29
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=0afec66085a85191e9dd2a4a6646c7c9a94688d1
PKG_SOURCE_URL:=https://github.com/XTLS/Xray-core
PKG_MIRROR_HASH:=955d321034ff410bf9cbe7191e2b5a9950ef1cf7a57ff1e9dd0411e556c26492

PKG_LICENSE:=MPL-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/xray/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=a personal vpn server
  URL:=https://github.com/XTLS/Xray-core
  EXTRA_DEPENDS:=ca-bundle
endef

define Package/xray-core
  $(call Package/xray/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/xray-core_nohf
  $(call Package/xray/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/xray-core/description
 Project X originates from XTLS protocol, providing a set of network tools.
endef

Package/xray-core_nohf/description=$(Package/xray-core/description)

define Package/xray
  $(call Package/xray/Default)
  TITLE+= (scripts & configs)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
  DEPENDS:=+xray-core
endef

define Package/xray_nohf
  $(call Package/xray/Default)
  TITLE+= (scripts & configs)
  VARIANT:=nohf
  DEPENDS:=+xray-core_nohf
endef

define Package/xray/description
  $(call Package/xray-core/description)
  (scripts & configs)
endef

Package/xray_nohf/description=$(Package/xray/description)

define Package/xray/conffiles
/opt/etc/xray/config.json
endef

Package/xray_nohf/conffiles=$(Package/xray/conffiles)

XIMPORTPATH:=$(call tolower,$(XIMPORTPATH))

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/core.build=$(COMMIT_SHORT)'

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
