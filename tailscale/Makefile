# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2025 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=tailscale
PKG_VERSION:=1.82.5
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=e4d64c6faf827a308ec20b39651225178e6743c0
PKG_SOURCE_URL:=https://github.com/tailscale/tailscale
PKG_MIRROR_HASH:=9a4996f787f17bedc1b96cbb76ccdb9d4da24b827bcefd4f8f460abc2e516e10

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/tailscale/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=VPN
	TITLE:=Private WireGuard networks made easy
	URL:=https://tailscale.com/
	MAINTAINER:=Entware team, https://entware.net
	EXTRA_DEPENDS:=ca-bundle, coreutils-nohup
endef

define Package/tailscale
	$(call Package/tailscale/Default)
	VARIANT:=hf
endef

define Package/tailscale_nohf
	$(call Package/tailscale/Default)
	VARIANT:=nohf
	DEPENDS:=@arm
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
