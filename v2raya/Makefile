# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2025 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=v2rayA
PKG_VERSION:=2.2.6.7
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/v2rayA/v2rayA
PKG_MIRROR_HASH:=0250b87c23fa02919b39044a950e1934f73c124c559cb9adcbbb00aa720ff5b5

PKG_LICENSE:=AGPL-3.0-only
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/v2raya/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=A Linux web GUI client of Project V
  URL:=https://v2raya.org
  DEPENDS:=+ca-bundle +iptables
endef

define Package/v2raya
  $(call Package/v2raya/Default)
  VARIANT:=hf
endef

define Package/v2raya_nohf
  $(call Package/v2raya/Default)
  VARIANT:=nohf
  DEPENDS+=@arm
endef

define Package/v2raya/description
  A web GUI client of Project V which supports VMess,
  VLESS, SS, SSR, Trojan, Tuic and Juicity protocols.
endef

Package/v2raya_nohf/description=$(Package/v2raya/description)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/conf.Version=v$(PKG_VERSION)'

GO_SRC_SUBDIR:=service

GO_TAGS:=with_gvisor

WEB_FILE:=$(PKG_NAME)-web-$(PKG_VERSION).tar.gz
define Download/v2raya-web
	URL:=https://github.com/v2rayA/v2rayA/releases/download/v$(PKG_VERSION)/
	URL_FILE:=web.tar.gz
	FILE:=$(WEB_FILE)
	HASH:=d871f119812979a20da3f57a792d7842dad4c4b528c8ec9e4a9aea29b8508147
endef

define Build/Prepare
	$(call Build/Prepare/Default)
	$(HOST_TAR) -xzf $(DL_DIR)/$(WEB_FILE) -C $(PKG_BUILD_DIR)/service/server/router 
endef

define Package/v2raya/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/v2rayA $(1)/opt/bin/v2raya
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S24v2raya $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/v2raya
	$(INSTALL_DIR) $(1)/opt/share/v2ray
endef

Package/v2raya_nohf/install=$(Package/v2raya/install)

$(eval $(call Download,v2raya-web))
$(eval $(call BuildPackage,v2raya))
$(eval $(call BuildPackage,v2raya_nohf))
