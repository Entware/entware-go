#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tailscale
PKG_VERSION:=1.36.2
PKG_RELEASE:=1

PKG_GOGET:=github.com/tailscale/tailscale

PKG_SOURCE_VERSION:=0438c67e2517c78feeaf0d9f61ea2a6303dd875c

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=8c909fa898ef4e2e0b8e8aa5b261927257a76811962a4f89e1b085bd27087fc5

PKG_GOGET:=github.com/tailscale/tailscale

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/tailscale/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=VPN
	TITLE:=Private WireGuard networks made easy
	URL:=https://tailscale.com/
	MAINTAINER:=Entware team, https://entware.net
	DEPENDS:=+ca-bundle
endef

define Package/tailscale
	$(call Package/tailscale/Default)
	VARIANT:=hf
endef

define Package/tailscale_nohf
	$(call Package/tailscale/Default)
	VARIANT:=nohf
	DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/tailscale/description
 Zero config VPN. Installs on any device in minutes, manages
 firewall rules for you, and works from anywhere
endef

Package/tailscale_nohf/description=$(Package/tailscale/description)

GIT_HASH:=$(shell echo $(PKG_SOURCE_VERSION) | cut -b -9)
PKG_SHORT_VER:=$(word 1,$(subst ., ,$(PKG_VERSION))).$(word 2,$(subst ., ,$(PKG_VERSION)))

GO_LDFLAGS += \
	-X 'tailscale.com/version.Long=$(PKG_VERSION)' \
	-X 'tailscale.com/version.Short=$(PKG_SHORT_VER)' \
	-X 'tailscale.com/version.GitCommit=$(GIT_HASH)'

GO_VARS += GO111MODULE=on

GO_TARGET:=tailscale.com/cmd/tailscale tailscale.com/cmd/tailscaled

define Package/tailscale/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/tailscale{,d} $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S06tailscaled $(1)/opt/etc/init.d/
endef

Package/tailscale_nohf/install=$(Package/tailscale/install)

$(eval $(call BuildPackage,tailscale))
$(eval $(call BuildPackage,tailscale_nohf))
