# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=sing-box
PKG_VERSION:=1.13.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/SagerNet/sing-box
PKG_MIRROR_HASH:=f8d2653d8536f1da3c70972534f1c6de36170ec37a4b75fc0b75ab2698d91cd3

PKG_LICENSE:=GPL-3.0-or-later
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1
PKG_CGO_ENABLED:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/sing-box/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=The universal proxy platform
  URL:=https://sing-box.sagernet.org
  PROVIDES:=sing-box sing-box-go
  DEPENDS:=+libatomic +libc +libgcc +libpthread +librt
endef

define Package/sing-box-go
  $(call Package/sing-box/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/sing-box-go_nohf
  $(call Package/sing-box/Default)
  VARIANT:=nohf
  DEPENDS+=@arm
endef

define Package/sing-box-go/description
 Sing-box is a fast, customizable and univsersal proxy platform that
can be used to create network proxy servers, clients and transparent proxies.
endef

Package/sing-box-go_nohf/description=$(Package/sing-box-go/description)

define Package/sing-box-go/conffiles
/opt/etc/sing-box/config.json
endef

Package/sing-box-go_nohf/conffiles=$(Package/sing-box-go/conffiles)

XIMPORTPATH:=$(call tolower,$(XIMPORTPATH))

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/constant.Version=$(PKG_VERSION)' \
	-X 'internal/godebug.defaultGODEBUG=multipathtcp=0' \
	-checklinkname=0

GO_TARGET:=./cmd/sing-box

GO_TAGS:= \
	badlinkname, \
	tfogo_checklinkname0, \
	with_acme, \
	with_ccm, \
	with_clash_api, \
	with_dhcp, \
	with_embedded_tor, \
	with_grpc, \
	with_gvisor, \
	$(if $(CONFIG_mips),,with_naive_outbound), \
	with_ocm, \
	with_quic, \
	with_tailscale, \
	with_utls, \
	with_v2ray_api, \
	with_wireguard

define Package/sing-box-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/sing-box $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/sing-box
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/release/config/config.json $(1)/opt/etc/sing-box
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99sing-box $(1)/opt/etc/init.d
endef

Package/sing-box-go_nohf/install=$(Package/sing-box-go/install)

$(eval $(call BuildPackage,sing-box-go))
$(eval $(call BuildPackage,sing-box-go_nohf))
