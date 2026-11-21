# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2026 Entware

include $(TOPDIR)/rules.mk

PKG_NAME:=ipp-usb
PKG_VERSION:=0.9.34
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/OpenPrinting/ipp-usb/tar.gz/refs/tags/$(PKG_VERSION)?
PKG_HASH:=4f0ada8593fda3f4239a50fcf24a625842143039de97708281e7b8c0cdff201a

PKG_LICENSE:=BSD-2-Clause
PKG_LICENSE_FILES:=LICENSE
PKG_BUILD_PARALLEL:=1

PKG_CGO_ENABLED:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/ipp-usb/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=IPP-over-USB printer and scanner proxy
  URL:=https://github.com/OpenPrinting/ipp-usb
  DEPENDS:=+libusb-1.0 +libavahi-client +libpthread
  PROVIDES:=ipp-usb
endef

define Package/ipp-usb
  $(call Package/ipp-usb/Default)
  VARIANT:=hf
  DEFAULT_VARIANT:=1
endef

define Package/ipp-usb_nohf
  $(call Package/ipp-usb/Default)
  DEPENDS+=@arm
  VARIANT:=nohf
endef

GO_TAGS:=nethttpomithttp2
GO_BUILD_ARGS:=-mod=vendor

define Package/ipp-usb/conffiles
/opt/etc/ipp-usb/ipp-usb.conf
endef

Package/ipp-usb_nohf/conffiles=$(Package/ipp-usb/conffiles)

define Package/ipp-usb/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/ipp-usb $(1)/opt/bin/ipp-usb
	$(INSTALL_DIR) $(1)/opt/etc/ipp-usb $(1)/opt/share/ipp-usb/quirks
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/ipp-usb.conf $(1)/opt/etc/ipp-usb/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ipp-usb-quirks/* $(1)/opt/share/ipp-usb/quirks/
endef

Package/ipp-usb_nohf/install=$(Package/ipp-usb/install)

$(eval $(call BuildPackage,ipp-usb))
$(eval $(call BuildPackage,ipp-usb_nohf))
