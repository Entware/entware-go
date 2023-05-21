#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tailscale
PKG_VERSION:=1.40.1
PKG_RELEASE:=1

PKG_SOURCE:=tailscale-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/tailscale/tailscale/tar.gz/v$(PKG_VERSION)?
PKG_HASH:=9c0a9648c921f695fc501536e69c8b4998d318256c8049de538f72fbe1491c18

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

GO_LDFLAGS += \
	-X 'tailscale.com/version.longStamp=$(PKG_VERSION)-$(PKG_RELEASE) (Entware)' \
	-X 'tailscale.com/version.shortStamp=$(PKG_VERSION)'

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
