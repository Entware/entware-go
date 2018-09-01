#
# Copyright (C) 2011-2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rclone_nohf
PKG_VERSION:=1.42
PKG_RELEASE:=1
PKG_GOGET:=github.com/ncw/rclone

GOPKG_SOURCE=GO_rclone-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=a9adb4389628c086c0183c8daa1c8a59004f08b6

#do not build both packages in parallel
PKG_BUILD_DEPENDS:=rclone

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

GOARM=GOARM=5

define Package/rclone_nohf
	$(call Package/gopackage/Default)
	DEPENDS:=@TARGET_armv7_3_2||@TARGET_armv7_2_6
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
	$(INSTALL_DIR) $(1)/opt/bin $(1)/opt/var/rclone
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/rclone $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/var/rclone
endef

$(eval $(call BuildPackage,rclone_nohf))
