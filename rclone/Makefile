#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=rclone
PKG_VERSION:=1.63.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=bd1fbcae12f795f498c7ace6af9d9cc218102094
PKG_SOURCE_URL:=https://github.com/rclone/rclone
PKG_MIRROR_HASH:=ef4d2af85f647d2108da56f591ef20911d71e39a2689cae81ec6df7215e2bd55

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
