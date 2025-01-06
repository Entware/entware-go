# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=restic
PKG_VERSION:=0.17.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/restic/restic
PKG_MIRROR_HASH:=701a2cf5ca6fe4a82de4e8d29253ea58c55d3fae4940a61891554f7772db48dd

PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

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
	DEPENDS:=@arm
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
