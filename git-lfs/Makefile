# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023-2024 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=git-lfs
PKG_VERSION:=3.5.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=e237bb3a364603cbb92cabc34b8401d1ad5d795b
PKG_SOURCE_URL:=https://github.com/git-lfs/git-lfs
PKG_MIRROR_HASH:=3374f2f889c1a6078e5b4876dc7bf20912d7afe318d01cc65bffe5a63c755052

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE.md

PKG_BUILD_PARALLEL:=1

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
  DEPENDS+=@arm
endef

define Package/git-lfs/description
  Git Large File Storage (LFS) replaces large files such as audio samples,
  videos, datasets, and graphics with text pointers inside Git, while storing
  the file contents on a remote server like GitHub.com or GitHub Enterprise.
endef

Package/git-lfs_nohf/description=$(Package/git-lfs/description)

define Build/FixHelp
	( cd $(PKG_BUILD_DIR); $(GO_BIN_GENERATE) ./commands; )
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
