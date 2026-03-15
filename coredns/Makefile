# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2025-2026 Entware

# https://github.com/Entware/Entware/issues/1000

include $(TOPDIR)/rules.mk

PKG_NAME:=coredns
PKG_VERSION:=1.14.2
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE_URL:=https://github.com/coredns/coredns
PKG_MIRROR_HASH:=6d82a06f7fe8b0f54a919058e8cd2839a113b81dd9d0217e280d2bea665668ce

PKG_MAINTAINER:=Entware team, https://entware.net
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/coredns/Default
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=IP Addresses and Names
  TITLE:=DNS server that chains plugins
  URL:=https://coredns.io
  PROVIDES:=coredns
  EXTRA_DEPENDS:=ca-bundle
endef

define Package/coredns
  $(call Package/coredns/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/coredns_nohf
  $(call Package/coredns/Default)
  VARIANT:=nohf
  DEPENDS:=@arm
endef

define Package/coredns/description
  CoreDNS is a DNS server/forwarder that chains plugins.
  Each plugin performs a (DNS) function.
endef

Package/coredns_nohf/description=$(Package/coredns/description)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/coremain.GitCommit=$(COMMIT_SHORT)'

define Build/Compile
	( cd $(PKG_BUILD_DIR); \
		$(GO_BIN_MOD_DOWNLOAD); \
		$(GO_BIN_GENERATE) coredns.go; \
		$(GO_BIN_GET); \
	)
	$(call Build/Compile/Go)
endef

define Package/coredns/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/coredns $(1)/opt/sbin
endef

Package/coredns_nohf/install=$(Package/coredns/install)

$(eval $(call BuildPackage,coredns))
$(eval $(call BuildPackage,coredns_nohf))
