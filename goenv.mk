PKG_BUILD_FLAGS:=no-mips16
PKG_BUILD_PARALLEL:=1
RSTRIP:=:
STRIP:=:

COMMIT_SHORT:=$(shell echo $(PKG_SOURCE_VERSION) | cut -b -9)
XIMPORTPATH:=$(shell echo $(PKG_SOURCE_URL) | cut -d/ -f3-)

GO_VARS += GOWORK=off
