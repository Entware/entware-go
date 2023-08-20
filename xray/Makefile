#
# Copyright (C) 2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=xray
PKG_VERSION:=1.7.5
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=15999e5c2aa92abe063cea03803d06b29e37e25b
PKG_SOURCE_URL:=https://github.com/XTLS/Xray-core
PKG_MIRROR_HASH:=af828c96319d084979c1df5816a56da42f3c27dc127fce107d9f45594a95cf02

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/xray/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=Project X originates from XTLS protocol, providing a set of network tools
	URL:=https://github.com/XTLS/Xray-core
	MAINTAINER:=Entware team, https://entware.net
	DEPENDS:=+ca-bundle
endef

define Package/xray
	$(call Package/xray/Default)
	VARIANT:=hf
endef

define Package/xray_nohf
	$(call Package/xray/Default)
	VARIANT:=nohf
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/xray/description
 A personal vpn server
endef

Package/xray_nohf/description=$(Package/xray/description)


Package/xray_nohf/conffiles=$(Package/xray/conffiles)

GO_LDFLAGS += -buildid=

GO_BUILD_ARGS += -a

GO_TARGET:=./main


define Package/xray/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/main $(1)/opt/sbin/xray
endef

Package/xray_nohf/install=$(Package/xray/install)

$(eval $(call BuildPackage,xray))
$(eval $(call BuildPackage,xray_nohf))
