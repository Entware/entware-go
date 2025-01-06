# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=gost-go
PKG_VERSION:=3.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/go-gost/gost
PKG_MIRROR_HASH:=0a417befd0b8cfa9c46d65125610df40519aac403664ea37f0ad8f9a6e8330e2

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/gost-go/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=VPN
	TITLE:=GO Simple Tunnel
	URL:=https://gost.run
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/gost-go
	$(call Package/gost-go/Default)
	VARIANT:=hf
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
