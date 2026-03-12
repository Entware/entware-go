# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2025-2026 Entware

# https://github.com/Entware/Entware/issues/1000

include $(TOPDIR)/rules.mk

PKG_NAME:=meshname
PKG_VERSION:=0.2.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/zhoreeq/meshname
PKG_MIRROR_HASH:=43c4277ecc75615e0f2b2ecc9eee6e7b210a48544f188cab6b28188e02d8dc4f

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/meshname/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=universal naming system for all IPv6-based mesh networks
  URL:=https://github.com/zhoreeq/meshname
  PROVIDES:=meshname
  EXTRA_DEPENDS:=ca-bundle
endef

define Package/meshname
  $(call Package/meshname/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/meshname_nohf
  $(call Package/meshname/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/meshname/description
  A universal naming system for all IPv6-based mesh networks,
  including CJDNS and Yggdrasil. Implements the Meshname protocol.
endef

Package/meshname_nohf/description=$(Package/meshname/description)

GO_TARGET:=./cmd/meshnamed

define Package/meshname/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/meshnamed $(1)/opt/sbin
endef

Package/meshname_nohf/install=$(Package/meshname/install)

$(eval $(call BuildPackage,meshname))
$(eval $(call BuildPackage,meshname_nohf))
