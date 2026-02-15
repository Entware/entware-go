# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=xray
PKG_VERSION:=26.1.18
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=7ff06f65eccdcd2f5722ee369d23b699aeb5cc0f
PKG_SOURCE_URL:=https://github.com/XTLS/Xray-core
PKG_MIRROR_HASH:=5bada908f888c248a44be2ea4aa39a3e9c653fdab2dc500565c9f08d51d524f0

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
