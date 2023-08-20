#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=frp
PKG_VERSION:=0.51.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=466d69eae08e44f118302cf433d3f4d6e8d04893
PKG_SOURCE_URL:=https://github.com/fatedier/frp
PKG_MIRROR_HASH:=bb76563cf6a442824ec432f07523a2a19afaf781fb9175fb45ac37af7ed89f02

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/frp/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Routing and Redirection
	TITLE:=frp is a fast reverse proxy
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
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/frp-go/description
 frp is a fast reverse proxy that allows you to expose a local server located behind a NAT or firewall to the Internet.
 It currently supports TCP and UDP, as well as HTTP and HTTPS protocols, enabling requests to be forwarded to internal services via domain name.
 frp also offers a P2P connect mode
endef

Package/frp-go_nohf/description=$(Package/frp/description)

GO_VARS += GO111MODULE=on

GO_TARGET:=./cmd/frps ./cmd/frpc

define Package/frp-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/* $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/conf/* $(1)/opt/etc
endef

Package/frp-go_nohf/install=$(Package/frp/install)

$(eval $(call BuildPackage,frp-go))
$(eval $(call BuildPackage,frp-go_nohf))
