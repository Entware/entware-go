# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=restic
PKG_VERSION:=0.16.4
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=3786536dc18ef27aedcfa8e4c6953b48353eee79
PKG_SOURCE_URL:=https://github.com/restic/restic
PKG_MIRROR_HASH:=98ca6adc45c857e93571b027036fb8b3faead569bfead2c57a2388c6eac328bd

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/restic-go/Default
	SECTION:=utils
	CATEGORY:=Utilities
	SUBMENU:=Backup
	TITLE:=Fast, secure, efficient backup program
	URL:=https://restic.net
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
 restic is a backup program that is fast, efficient and secure.
 It supports the three major operating systems (Linux, macOS, Windows) and a
 few smaller ones (FreeBSD, OpenBSD).
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
