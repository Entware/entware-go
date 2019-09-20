#
# Copyright (C) 2011-2019 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=rclone
PKG_VERSION:=1.48.0
PKG_RELEASE:=1
PKG_GOGET:=github.com/ncw/rclone

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE=$(GOPKG_SOURCE)
PKG_COMMIT=245fed513ad33c7aacad2c6d591c81f646d44dc1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/rclone/Default
	$(call Package/gopackage/Default)
	TITLE:=Rclone is a command line program to sync files and directories to and from cloud storages
	URL:=https://github.com/ncw/rclone
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

define Package/rclone/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/$(PKG_NAME) $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/var/rclone
endef

Package/rclone_nohf/install=$(Package/rclone/install)

$(eval $(call BuildPackage,rclone))
$(eval $(call BuildPackage,rclone_nohf))

