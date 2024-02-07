# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=tailscale
PKG_VERSION:=1.58.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=b0e1bbb62ef3834e99f5212b44043cec1866b07e
PKG_SOURCE_URL:=https://github.com/tailscale/tailscale
PKG_MIRROR_HASH:=b9a5c450859472cb7a33954b3fdb43ca67f811415e31dcb3ca33dea17d2598e8

include ../goenv.mk
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

PKG_SHORT_VER:=$(subst $(space),.,$(wordlist 1,2,$(subst .,$(space),$(PKG_VERSION))))

GO_LDFLAGS += \
	-X 'tailscale.com/version.longStamp=$(PKG_VERSION)' \
	-X 'tailscale.com/version.shortStamp=$(PKG_SHORT_VER)' \
	-X 'tailscale.com/version.gitCommitStamp=$(COMMIT_SHORT)'

GO_VARS += GO111MODULE=on

GO_TARGET:=./cmd/tailscale ./cmd/tailscaled

define Package/tailscale/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/tailscale{,d} $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S06tailscaled $(1)/opt/etc/init.d/
endef

Package/tailscale_nohf/install=$(Package/tailscale/install)

$(eval $(call BuildPackage,tailscale))
$(eval $(call BuildPackage,tailscale_nohf))
