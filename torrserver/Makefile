#
# Copyright (C) 2011-2021 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# The newer version has different dependency tracking
#

include $(TOPDIR)/rules.mk

PKG_NAME:=torrserver
PKG_VERSION:=1.2.117
PKG_RELEASE:=1
PKG_GOGET:=github.com/YouROK/TorrServer

GOPKG_SOURCE=GO_$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE).tar.bz2

#!!! uncomment PKG_SOURCE to download fixed version
PKG_SOURCE:=$(GOPKG_SOURCE)
PKG_HASH:=b6482fd85d0c482de0d6f9f015403f1bebfb701f06c952f3a03df13f021e52da
PKG_COMMIT:=46246d9dfff9bd2af450dea0f032d822974176d0

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DEPENDS:=node-yarn/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

ifeq ($(BUILD_VARIANT),nohf)
GOARM=GOARM=5
endif

define Package/torrserver/Default
	$(call Package/gopackage/Default)
	TITLE:=TorrServer - stream torrent to http
	URL:=https://github.com/YouROK/TorrServer
endef

define Package/torrserver
	$(call Package/torrserver/Default)
	VARIANT:=hf
endef

define Package/torrserver_nohf
	$(call Package/torrserver/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/torrserver/description
 torrserver is a server to stream torrent via http to torrserv client
endef

Package/torrserver_nohf/description=$(Package/torrserver/description)

define Build/Compile
        (\
		cd $(PKG_BUILD_DIR); \
		mkdir -p bin; \
		cd src/$(PKG_GOGET); \
		PATH="$(GOROOT)/bin:$$$$PATH" LDFLAGS="'-s -w'" FAILURES="" go run gen_web.go; \
		cd server; \
		$(GOROOT)/bin/go mod tidy; \
		CGO_ENABLED=0 GOOS=linux GOARCH=$(GOARCH) $(GOARM) GOPATH=$(PKG_BUILD_DIR) $(GOROOT)/bin/go build -tags nosqlite -ldflags="-s -w" -x -v -o ${PKG_BUILD_DIR}/bin/${PKG_NAME} ./cmd; \
		chmod -R +w $(PKG_BUILD_DIR)/pkg; \
        )
endef


define Package/torrserver/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/torrserver $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) files/S90torrserver $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/torrserver
	touch $(1)/opt/etc/torrserver/.keep
endef

Package/torrserver_nohf/install=$(Package/torrserver/install)

$(eval $(call BuildPackage,torrserver))
$(eval $(call BuildPackage,torrserver_nohf))

