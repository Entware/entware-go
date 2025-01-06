# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=kopia
PKG_VERSION:=0.18.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=c70f1a1c1164ee8676f85f9a1cea6de0a782a3ae
PKG_SOURCE_URL:=https://github.com/kopia/kopia
PKG_MIRROR_HASH:=a2e3519b3d24867d4b7356c014aaade91b3bb9e3f9271c46e1ee8c0112760f3f

PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/kopia/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Backup
  TITLE:=backup/restore tool
  URL:=https://kopia.io/
  MAINTAINER:=Entware team, https://entware.net
endef

define Package/kopia
  $(call Package/kopia/Default)
  VARIANT:=hf
endef

define Package/kopia_nohf
  $(call Package/kopia/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/kopia/description
  Kopia is a fast and secure open-source backup/restore tool that allows
  you to create encrypted snapshots of your data and save the snapshots
  to remote or cloud storage of your choice, to network-attached storage
  or server, or locally on your machine.
endef

Package/kopia_nohf/description=$(Package/kopia/description)

define Package/kopia/conffiles
/opt/etc/kopia/kopia.conf
endef

Package/kopia_nohf/conffiles=$(Package/kopia/conffiles)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/repo.BuildVersion=$(PKG_VERSION)' \
	-X '$(XIMPORTPATH)/repo.BuildInfo=$(COMMIT_SHORT)' \
	-X '$(XIMPORTPATH)/repo.BuildGitHubRepo=$(PKG_NAME)'

define Package/kopia/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/kopia $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/kopia
	$(INSTALL_DATA) ./files/kopia.conf $(1)/opt/etc/kopia
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S99kopia $(1)/opt/etc/init.d
endef

Package/kopia_nohf/install=$(Package/kopia/install)

$(eval $(call BuildPackage,kopia))
$(eval $(call BuildPackage,kopia_nohf))
