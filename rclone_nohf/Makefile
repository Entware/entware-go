#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rclone_nohf
PKG_VERSION:=1.37
PKG_RELEASE:=1
PKG_GOGET:=github.com/ncw/rclone

GOPKG_SOURCE=GO_rclone-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=a73ecec11f6a707273a44984e73e84b471a90710

#do not build both packages in parallel
PKG_BUILD_DEPENDS:=rclone

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

GOARM=GOARM=5

define Package/rclone_nohf
	$(call Package/gopackage/Default)
	DEPENDS:=@TARGET_armv7_3x
	TITLE:=Rclone is a command line program to sync files and directories to and from cloud storages (arm version with no hard float)
	URL:=https://github.com/ncw/rclone
endef

define Package/rclone_nohf/description
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

define Package/rclone_nohf/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/rclone $(1)/opt/bin
endef

$(eval $(call BuildPackage,rclone_nohf))
