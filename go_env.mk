# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2024 Entware

COMMIT_SHORT:=$(call version_abbrev,$(PKG_SOURCE_VERSION))
XIMPORTPATH:=$(shell echo $(PKG_SOURCE_URL) | cut -d/ -f3-)

GOARCH:=$(subst aarch64,arm64,$(subst mipsel,mipsle,$(subst x86_64,amd64,$(ARCH))))

GO_ENV_COMMON:= \
	GOCACHE=$(TMP_DIR)/go-build \
	GOMODCACHE=$(DL_DIR)/go-mod-cache \
	GOPATH=$(DL_DIR)/go-mod-cache \
	GOTMPDIR=$(TMP_DIR) \
	GOENV=off \
	GOTOOLCHAIN=local \
	GOWORK=off

ifeq ($(PKG_CGO_ENABLED),1)
  GO_VARS += CGO_ENABLED=1
else
  GO_VARS += CGO_ENABLED=0
endif

# cc1: Error: -mips32r2 conflicts with the other architecture options, which imply -mips32
# gcc_mipsx.S: Assembler messages: Error: invalid operands ...
EXCLUDE_FLAGS = -mips16 -minterlink-mips16 -mips32r2

GO_VARS += \
	AR=$(TARGET_AR) \
	CC=$(TARGET_CC) \
	CXX=$(TARGET_CXX) \
	CGO_CFLAGS="$(filter-out $(EXCLUDE_FLAGS),$(TARGET_CFLAGS))" \
	CGO_CPPFLAGS="$(TARGET_CPPFLAGS) -I$(STAGING_DIR)/opt/include" \
	CGO_CXXFLAGS="$(filter-out $(EXCLUDE_FLAGS),$(TARGET_CXXFLAGS))" \
	CGO_FFLAGS='' \
	CGO_LDFLAGS="$(TARGET_LDFLAGS) -L$(STAGING_DIR)/opt/lib"

GO_VARS += GOOS=linux

GO_VARS += GOARCH=$(GOARCH)

# https://go.dev/wiki/MinimumRequirements:
# "The GOARM64 environment variable defaults to v8.0."
ifeq ($(ARCH),aarch64)
  GO_VARS += GOARM64=v8.0
endif

ifeq ($(ARCH),arm)
  ifeq ($(BUILD_VARIANT),hf)
	GO_VARS += GOARM=7,hardfloat
	### or (?)
	#GO_VARS += GOARM=7
	#GO_VARS += GOARMFP=hard
  else
	GO_VARS += GOARM=7,softfloat
	### or (?)
	#GO_VARS += GOARM=7
	#GO_VARS += GOARMFP=soft
  endif
endif

ifeq ($(ARCH),$(filter $(ARCH),mips mipsel))
  GO_VARS += GOMIPS=softfloat
endif

GO_VARS += \
	GOBIN=$(PKG_INSTALL_DIR)/bin \
	$(GO_ENV_COMMON)
