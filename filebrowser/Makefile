# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024-2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=filebrowser
PKG_VERSION:=2.55.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=08c8ede587240472cd1524e40e514fc2bbc3466e
PKG_SOURCE_URL:=https://github.com/filebrowser/filebrowser
PKG_MIRROR_HASH:=82f9ee37b6f5ff190246c99bade929ccb36287395fb4e8cd88d5d5da86bd3dd7

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_DEPENDS:=node-pnpm/host
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/filebrowser/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Filesystem
  TITLE:=Web File Browser
  URL:=https://filebrowser.org
  PROVIDES:=filebrowser
endef

define Package/filebrowser
  $(call Package/filebrowser/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/filebrowser_nohf
  $(call Package/filebrowser/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/filebrowser/description
  filebrowser provides a file managing interface within a specified
  directory and it can be used to upload, delete, preview, rename and edit your
  files. It allows the creation of multiple users and each user can have its own
  directory. It can be used as a standalone app or as a middleware.
endef

Package/filebrowser_nohf/description=$(Package/filebrowser/description)

define Package/filebrowser/conffiles
/opt/etc/filebrowser/filebrowser.conf
endef

Package/filebrowser_nohf/conffiles=$(Package/filebrowser/conffiles)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/v2/version.Version=$(PKG_VERSION)' \
	-X '$(XIMPORTPATH)/v2/version.CommitSHA=$(COMMIT_SHORT)'

GO_VARS += \
	GOGC=off \
	GO111MODULE=on

define Build/Compile
	( cd $(PKG_BUILD_DIR)/frontend; \
		XDG_DATA_HOME=$(TMP_DIR)/pnpm-cache \
		pnpm install --frozen-lockfile; \
		XDG_DATA_HOME=$(TMP_DIR)/pnpm-cache \
		pnpm run build; \
	)
	$(call Build/Compile/Go)
endef

define Package/filebrowser/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/filebrowser $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99filebrowser $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/filebrowser
	$(INSTALL_DATA) ./files/filebrowser.conf $(1)/opt/etc/filebrowser
endef

Package/filebrowser_nohf/install=$(Package/filebrowser/install)

$(eval $(call BuildPackage,filebrowser))
$(eval $(call BuildPackage,filebrowser_nohf))
