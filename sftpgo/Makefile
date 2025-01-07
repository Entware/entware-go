# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=sftpgo
PKG_VERSION:=2.6.4
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2024-11-27
PKG_SOURCE_VERSION:=386448e6cbe47de3fad572fb3776aeda4b35d6ed
PKG_SOURCE_URL:=https://github.com/drakkan/sftpgo
PKG_MIRROR_HASH:=764828fa96c82c159eeb26bfe0b7506bdd02f10056d051f02fd24aaf55a393fc

PKG_LICENSE:=AGPL-3.0-only
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Entware team, https://entware.net

PKG_BUILD_PARALLEL:=1
PKG_CGO_ENABLED:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/sftpgo/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=File Transfer
  TITLE:=SFTP server
  URL:=https://sftpgo.com/
endef

define Package/sftpgo
  $(call Package/sftpgo/Default)
  VARIANT:=hf
endef

define Package/sftpgo_nohf
  $(call Package/sftpgo/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/sftpgo/description
  Fully featured and highly configurable SFTP server with optional
  HTTP/S, FTP/S and WebDAV support.
  Supported storage backends: local filesystem, encrypted local filesystem, S3
  (compatible) Object Storage, Google Cloud Storage, Azure Blob Storage, other
  SFTP servers.
endef

Package/sftpgo_nohf/description=$(Package/sftpgo/description)

# https://github.com/drakkan/sftpgo/blob/main/docs/build-from-source.md
# FEATURES=nogcs,nos3,noazblob,nobolt,nomysql,nopgsql,nosqlite,noportable,nometrics,bundle,unixcrypt

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/v2/internal/version.commit=$(COMMIT_SHORT)' \
	-X '$(XIMPORTPATH)/v2/internal/version.date=$(PKG_SOURCE_DATE)'

GO_TAGS:=nobolt, nomysql, nopgsql, unixcrypt

define Package/sftpgo/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S21sftpgo $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/sftpgo
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/sftpgo.json $(1)/opt/etc/sftpgo
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/sftpgo $(1)/opt/sbin/sftpgo
	$(INSTALL_DIR) $(1)/opt/share/sftpgo
	$(CP) $(PKG_BUILD_DIR)/{openapi,static,templates} $(1)/opt/share/sftpgo
	$(INSTALL_DIR) $(1)/opt/srv/sftpgo/{data,backups}
	$(INSTALL_DIR) $(1)/opt/var/lib/sftpgo/certs
endef

Package/sftpgo_nohf/install=$(Package/sftpgo/install)

$(eval $(call BuildPackage,sftpgo))
$(eval $(call BuildPackage,sftpgo_nohf))
