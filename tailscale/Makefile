# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2021-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=tailscale
PKG_VERSION:=1.96.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=6af139fa027b44475bd3c32e581f115165ab2ebb
PKG_SOURCE_URL:=https://github.com/tailscale/tailscale
PKG_MIRROR_HASH:=71705f2c97d0fd78daa4c8dd911a12d5ac3975a1a73b537829197cbdff9972bb

PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/tailscale/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=Private WireGuard networks made easy
  URL:=https://tailscale.com/
  PROVIDES:=tailscale
  EXTRA_DEPENDS:=ca-bundle, coreutils-nohup
endef

define Package/tailscale
  $(call Package/tailscale/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
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
