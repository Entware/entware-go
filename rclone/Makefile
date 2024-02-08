# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2016-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=rclone
PKG_VERSION:=1.65.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=ffcaa6cd927929a871609a8d6ce0004324feb8d0
PKG_SOURCE_URL:=https://github.com/rclone/rclone
PKG_MIRROR_HASH:=05d7a723fd60b5140e631532fdc680847406862543832cd4af7e2cd806f42761

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/rclone/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=File Transfer
	TITLE:=rsync for cloud storage
	URL:=https://rclone.org
	MAINTAINER:=Entware team, https://entware.net
endef

define Package/rclone
	$(call Package/rclone/Default)
	VARIANT:=hf
endef

define Package/rclone_nohf
	$(call Package/rclone/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/rclone/description
 Rclone is a command line program to sync files and directories to and from:
    Google Drive
    Amazon S3
    Openstack Swift / Rackspace cloud files / Memset Memstore
    Dropbox
    Google Cloud Storage
    Amazon Cloud Drive
    Microsoft One Drive
    Hubic
    Backblaze B2
    Yandex Disk
    The local filesystem
endef

Package/rclone_nohf/description=$(Package/rclone/description)

GO_LDFLAGS += \
        -X '$(XIMPORTPATH)/fs.Version=$(PKG_VERSION)'

GO_TAGS:=-tags=noselfupdate
GO_VARS += GO111MODULE=on

define Package/rclone/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/$(PKG_NAME) $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/var/cache/rclone
endef

Package/rclone_nohf/install=$(Package/rclone/install)

$(eval $(call BuildPackage,rclone))
$(eval $(call BuildPackage,rclone_nohf))
