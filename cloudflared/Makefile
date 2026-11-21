# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2021 ImmortalWrt.org
# Copyright (C) 2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=cloudflared
PKG_VERSION:=2026.10.6
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/cloudflare/cloudflared/tar.gz/$(PKG_VERSION)?
PKG_HASH:=eb4d6b02b017cd3e49676934f14fe3025cebb07f9f272cd60dd790a2d812b90b

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=no-mips16

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/cloudflared/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Web Servers/Proxies
  TITLE:=Cloudflare Tunnel client
  URL:=https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/get-started/
  DEPENDS:=+ca-bundle
  PROVIDES:=cloudflared
endef

define Package/cloudflared
  $(call Package/cloudflared/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/cloudflared_nohf
  $(call Package/cloudflared/Default)
  VARIANT:=nohf
  DEPENDS+=@arm
endef

define Package/cloudflared/description
  Contains the command-line client for Cloudflare Tunnel, a tunneling
  daemon that proxies traffic from the Cloudflare network to your origins.

  This daemon sits between Cloudflare network and your origin (e.g. a
  webserver). Cloudflare attracts client requests and sends them to you
  via this daemon, without requiring you to poke holes on your firewall
  --- your origin can remain as closed as possible.
endef

Package/cloudflared_nohf/description=$(Package/cloudflared/description)

define Package/cloudflared/conffiles
/opt/etc/cloudflared/config.yml
endef

Package/cloudflared_nohf/conffiles=$(Package/cloudflared/conffiles)

GO_TARGET:=./cmd/cloudflared
GO_LDFLAGS += \
	-X 'main.Version=$(PKG_VERSION)' \
	-X 'github.com/cloudflare/cloudflared/cmd/cloudflared/updater.BuiltForPackageManager=opkg'

define Package/cloudflared/install
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/etc/cloudflared
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/cloudflared $(1)/opt/bin/
	$(INSTALL_CONF) ./files/sample_config.yml $(1)/opt/etc/cloudflared/config.yml
endef

Package/cloudflared_nohf/install=$(Package/cloudflared/install)

$(eval $(call BuildPackage,cloudflared))
$(eval $(call BuildPackage,cloudflared_nohf))
