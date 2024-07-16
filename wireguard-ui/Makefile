# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=wireguard-ui
PKG_VERSION:=0.6.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-01-07
PKG_SOURCE_VERSION:=99104e429557a4cd6bda4b0c2550a656cdfe9bb7
PKG_SOURCE_URL:=https://github.com/ngoduykhanh/wireguard-ui
PKG_MIRROR_HASH:=3a319c17c2fd9d58402ea198379bfe9883c1611ab93a03b0bf1d73118cf2a084

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_DEPENDS:=node-yarn/host
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/wireguard-ui/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=Wireguard web interface
  URL:=https://github.com/ngoduykhanh/wireguard-ui
  DEPENDS:=+ca-bundle +iptables +jq +wireguard-tools @!LINUX_2_6_36
endef

define Package/wireguard-ui
  $(call Package/wireguard-ui/Default)
  VARIANT:=hf
endef

define Package/wireguard-ui_nohf
  $(call Package/wireguard-ui/Default)
  VARIANT:=nohf
  DEPENDS+=@arm
endef

define Package/wireguard-ui/description
  A web user interface to manage your WireGuard setup.
endef

Package/wireguard-ui_nohf/description=$(Package/wireguard-ui/description)

GO_BUILD_ARGS += -a

GO_LDFLAGS += \
	-X 'main.appVersion=v$(PKG_VERSION)' \
	-X 'main.buildTime=$(PKG_SOURCE_DATE)' \
	-X 'main.gitCommit=$(COMMIT_SHORT)' \
	-X 'main.gitRef=master'

define Build/Web
	( cd $(PKG_BUILD_DIR); $(SHELL) ./prepare_assets.sh; )
endef

Hooks/Compile/Pre += Build/Web

define Package/wireguard-ui/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S80wireguard-ui $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/wireguard-ui $(1)/opt/sbin/wireguard-ui
endef

Package/wireguard-ui_nohf/install=$(Package/wireguard-ui/install)

$(eval $(call BuildPackage,wireguard-ui))
$(eval $(call BuildPackage,wireguard-ui_nohf))
