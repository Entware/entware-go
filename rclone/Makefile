#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking

include $(TOPDIR)/rules.mk

PKG_NAME:=rclone
PKG_VERSION:=1.60.1
PKG_RELEASE:=1

PKG_GOGET:=github.com/rclone/rclone

PKG_SOURCE_VERSION:=ab8be2663fca662398983a9372f5ee1c39cb2862

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://$(PKG_GOGET)
PKG_MIRROR_HASH:=f47286312aa7192177c5238d194ca9d019698fb8921e8fab3e17711e5e3d8aaf

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
        -X '$(PKG_GOGET)/fs.Version=$(PKG_VERSION)'

GO_TAGS:=-tags=noselfupdate
GO_VARS += GO111MODULE=on

define Package/rclone/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/$(PKG_NAME) $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/var/cache/rclone
endef

Package/rclone_nohf/install=$(Package/rclone/install)

$(eval $(call BuildPackage,rclone))
$(eval $(call BuildPackage,rclone_nohf))
