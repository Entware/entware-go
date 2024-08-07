#
# Copyright (C) 2011-2023 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=headscale
PKG_VERSION:=v0.22.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=b01f1f1867136d9b2d7b1392776eb363b482c525
PKG_SOURCE_URL:=https://github.com/juanfont/headscale
PKG_MIRROR_HASH:=a7b80f3d7693876d4b6f90f2b4505f850ede17ce560df5bd588597d1c4347f9f

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/headscale/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=VPN
	TITLE:=An open source, self-hosted implementation of the Tailscale control server
	URL:=https://github.com/juanfont/headscale
	MAINTAINER:=Entware team, https://entware.net
	DEPENDS:=+ca-bundle @!(mips||mipsel)
endef

define Package/headscale
	$(call Package/headscale/Default)
	VARIANT:=hf
endef

define Package/headscale_nohf
	$(call Package/headscale/Default)
	VARIANT:=nohf
	DEPENDS+=@arm
endef

define Package/headscale/description
 Headscale aims to implement a self-hosted, open source alternative to the Tailscale control server.
 Headscale's goal is to provide self-hosters and hobbyists with an open-source server they can use for their projects and labs.
 It implements a narrow scope, a single Tailnet, suitable for a personal use, or a small open-source organisation.
endef

Package/headscale_nohf/description=$(Package/headscale/description)

define Package/headscale/conffiles
/opt/etc/headscale/config.yaml
endef

Package/headscale_nohf/conffiles=$(Package/headscale/conffiles)

GO_LDFLAGS += \
	-X '$(XIMPORTPATH)/cmd/headscale/cli.Version=$(PKG_VERSION)'

GO_BUILD_ARGS += -a

GO_TARGET:=./cmd/headscale

define Package/headscale/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/headscale $(1)/opt/bin
	$(INSTALL_DIR) $(1)/opt/etc/headscale
	$(CP) $(PKG_BUILD_DIR)/config-example.yaml $(1)/opt/etc/headscale/config.yaml
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S07headscale $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/var/{lib,run}/headscale
endef

Package/headscale_nohf/install=$(Package/headscale/install)

$(eval $(call BuildPackage,headscale))
$(eval $(call BuildPackage,headscale_nohf))
