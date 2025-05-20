# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024-2025 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=webtunnel
PKG_VERSION:=0.0.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/webtunnel
PKG_MIRROR_HASH:=78eb07588dcf99b55fa5e4410e7f44af2c2e4ff3f03f847483615a2ac5609fe2

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/webtunnel/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Pluggable Transport based on HTTP Upgrade(HTTPT)
  URL:=https://gitlab.torproject.org/tpo/anti-censorship/pluggable-transports/webtunnel
endef

define Package/webtunnel-client
  $(call Package/webtunnel/Default)
  VARIANT:=hf
endef

define Package/webtunnel-client_nohf
  $(call Package/webtunnel/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/webtunnel-server
  $(call Package/webtunnel/Default)
  VARIANT:=hf
endef

define Package/webtunnel-server_nohf
  $(call Package/webtunnel/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/webtunnel/description
  WebTunnel is pluggable transport that attempt to imitate web
  browsing activities based on HTTPT.
endef

Package/webtunnel-client/description=$(Package/webtunnel/description)
Package/webtunnel-client_nohf/description=$(Package/webtunnel/description)
Package/webtunnel-server/description=$(Package/webtunnel/description)
Package/webtunnel-server_nohf/description=$(Package/webtunnel/description)

GO_TARGET:=./main/client ./main/server

define Package/webtunnel-client/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/client $(1)/opt/sbin/webtunnel-client
endef

Package/webtunnel-client_nohf/install=$(Package/webtunnel-client/install)

define Package/webtunnel-server/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/server $(1)/opt/sbin/webtunnel-server
endef

Package/webtunnel-server_nohf/install=$(Package/webtunnel-server/install)

$(eval $(call BuildPackage,webtunnel-client))
$(eval $(call BuildPackage,webtunnel-client_nohf))
$(eval $(call BuildPackage,webtunnel-server))
$(eval $(call BuildPackage,webtunnel-server_nohf))
