#
# Copyright (C) 2023 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=git-lfs
PKG_VERSION:=3.4.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=d06d6e9efd78ff4f958b072146ce167d87f60285
PKG_SOURCE_URL:=https://github.com/git-lfs/git-lfs
PKG_MIRROR_HASH:=31f3a17a80f3b60006205cc3ebc7c7aab9eeab74500a081a52b6ef1830f9a068

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.md

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/git-lfs/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Git Large File Storage
  URL:=https://git-lfs.github.com
  MAINTAINER:=Entware team, https://entware.net
  DEPENDS:=+git
endef

define Package/git-lfs
  $(call Package/git-lfs/Default)
  VARIANT:=hf
endef

define Package/git-lfs_nohf
  $(call Package/git-lfs/Default)
  VARIANT:=nohf
  DEPENDS+=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/git-lfs/description
  Git Large File Storage (LFS) replaces large files such as audio samples,
  videos, datasets, and graphics with text pointers inside Git, while storing
  the file contents on a remote server like GitHub.com or GitHub Enterprise.
endef

Package/git-lfs_nohf/description=$(Package/git-lfs/description)

define Build/FixHelp
	( cd $(PKG_BUILD_DIR); $(GO_BIN) generate ./commands )
endef

Hooks/Compile/Pre += Build/FixHelp

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/v3/config.Vendor=Entware' \
	-X '$(XIMPORTPATH)/v3/config.GitCommit=$(COMMIT_SHORT)'

define Package/git-lfs/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/git-lfs $(1)/opt/bin
endef

Package/git-lfs_nohf/install=$(Package/git-lfs/install)

$(eval $(call BuildPackage,git-lfs))
$(eval $(call BuildPackage,git-lfs_nohf))
