#
# Copyright (C) 2011-2023 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=restic
PKG_VERSION:=0.16.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=eb33e564c9e707529fe3e62fe7bf5f6be133e145
PKG_SOURCE_URL:=https://github.com/restic/restic
PKG_MIRROR_HASH:=54e2e5046bc2c06a913be07fd6762e7ec836376aa8cdb4c44104d77523c726b5

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/restic-go/Default
	SECTION:=utils
	CATEGORY:=Utilities
	SUBMENU:=Backup
	TITLE:=restic is a backup program
	URL:=https://github.com/restic/restic
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/restic-go
	$(call Package/restic-go/Default)
	VARIANT:=hf
endef

define Package/restic-go_nohf
	$(call Package/restic-go/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/restic-go/description
  restic is a backup program that is fast, efficient and secure. It supports the three major operating systems (Linux, macOS, Windows) and a few smaller ones (FreeBSD, OpenBSD)
endef

Package/restic-go_nohf/description=$(Package/restic-go/description)


GO_TARGET:=./cmd/restic

define Package/restic-go/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/restic $(1)/opt/bin/
endef

Package/restic-go_nohf/install=$(Package/restic-go/install)

$(eval $(call BuildPackage,restic-go))
$(eval $(call BuildPackage,restic-go_nohf))
