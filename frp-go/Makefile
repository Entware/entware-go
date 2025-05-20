# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2025 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=frp
PKG_VERSION:=0.62.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/fatedier/frp
PKG_MIRROR_HASH:=50cf34716e43fcdf35e08dacc104d15c7cf7ae77c8cdfff128a0f1edf2c4ff11

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/frp/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Routing and Redirection
	TITLE:=fast reverse proxy
	URL:=https://github.com/fatedier/frp
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/frp-go
	$(call Package/frp/Default)
	VARIANT:=hf
endef

define Package/frp-go_nohf
	$(call Package/frp/Default)
	VARIANT:=nohf
	DEPENDS:=@arm
endef

define Package/frp-go/description
 frp is a fast reverse proxy that allows you to expose
 a local server located behind a NAT or firewall to the Internet.
 It currently supports TCP and UDP, as well as HTTP and HTTPS protocols,
 enabling requests to be forwarded to internal services via domain name.
 frp also offers a P2P connect mode.
endef

Package/frp-go_nohf/description=$(Package/frp/description)

define Package/frp-go/conffiles
/opt/etc/frp/
endef

Package/frp-go_nohf/conffiles=$(Package/frp-go/conffiles)

GO_VARS += GO111MODULE=on

GO_TAGS:=frpc, frps
GO_TARGET:=./cmd/frpc ./cmd/frps

define Package/frp-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/frp{c,s} $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/frp
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/*.toml $(1)/opt/etc/frp
endef

Package/frp-go_nohf/install=$(Package/frp/install)

$(eval $(call BuildPackage,frp-go))
$(eval $(call BuildPackage,frp-go_nohf))
