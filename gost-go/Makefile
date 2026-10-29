# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=gost-go
PKG_VERSION:=3.3.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/go-gost/gost
PKG_MIRROR_HASH:=df25862af0aab3b8e7b4c920efd67a272d3404292f19d351d1347975e21e665e

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/gost-go/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=GO Simple Tunnel
  URL:=https://gost.run
  PROVIDES:=gost-go
endef

define Package/gost-go
  $(call Package/gost-go/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/gost-go_nohf
  $(call Package/gost-go/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/gost-go/description
  GO Simple Tunnel - a simple tunnel written in golang.
endef

Package/gost-go_nohf/description=$(Package/gost-go/description)

GO_TARGET:=./cmd/gost

define Package/gost-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/gost $(1)/opt/bin/
endef

Package/gost-go_nohf/install=$(Package/gost-go/install)

$(eval $(call BuildPackage,gost-go))
$(eval $(call BuildPackage,gost-go_nohf))
