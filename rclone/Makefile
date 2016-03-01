#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rclone
PKG_VERSION:=go
PKG_RELEASE:=1
PKG_GOGET:=github.com/ncw/rclone

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/rclone
	SECTION:=Go
	CATEGORY:=Go
	DEPENDS:=+libgo +libpthread
	TITLE:=Rclone is a command line program to sync files and directories to and from cloud storages
	URL:=https://github.com/ncw/rclone
	MAINTAINER:=Entware team, http://entware.net
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

define Package/rclone/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/rclone $(1)/opt/bin
endef

$(eval $(call BuildPackage,rclone))
