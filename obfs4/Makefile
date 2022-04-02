#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=obfs4
PKG_VERSION:=0.0.13
PKG_RELEASE:=1
PKG_GOGET:=gitlab.com/yawning/obfs4

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE:=$(GOPKG_SOURCE)
PKG_HASH:=8b555ace115ef48ec1b31973b8189d90d7514ec48e2a779713d3673232f03992
PKG_COMMIT:=77af0cba934d73c4baeb709560bcfc9a9fbc661c

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/obfs4/Default
	$(call Package/gopackage/Default)
	TITLE:=A Tor pluggable transport proxy, implementing obfs4
	URL:=https://gitlab.com/yawning/obfs4
endef

define Package/obfs4
	$(call Package/obfs4/Default)
	VARIANT:=hf
	DEPENDS:=+tor
endef

define Package/obfs4_nohf
	$(call Package/obfs4/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2) +tor
endef

define Package/obfs4/description
obfs4proxy is a tool that attempts to circumvent censorship by
transforming the Tor traffic between the client and the bridge. This way
censors, who usually monitor traffic between the client and the bridge,
will see innocent-looking transformed traffic instead of the actual Tor
traffic.

obfs4proxy implements the obfsucation protocols obfs2, obfs3, and obfs4.

It is written in Go and is compliant with the Tor pluggable transports
specification, and its modular architecture allows it to support
multiple pluggable transports.
endef

Package/obfs4_nohf/description=$(Package/obfs4/description)

define Build/Compile
	(\
		cd $(PKG_BUILD_DIR)/src/$(PKG_GOGET); \
		CGO_ENABLED=0 GOOS=linux GOARCH=$(GOARCH) $(GOARM) \
		GOPATH=$$$$PATH:$(PKG_BUILD_DIR)/src/$(PKG_GOGET) \
		$(GOROOT)/bin/go build -ldflags="-s -w" \
		-o obfs4proxy/obfs4proxy ./obfs4proxy; \
	)
endef

define Package/obfs4/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/$(PKG_GOGET)/obfs4proxy/obfs4proxy $(1)/opt/sbin
endef

Package/obfs4_nohf/install=$(Package/obfs4/install)

$(eval $(call BuildPackage,obfs4))
$(eval $(call BuildPackage,obfs4_nohf))
