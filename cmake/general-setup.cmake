
# Put everything into a common prefix

include(GNUInstallDirs)
set(JULIA_PREFIX_DIR "${CMAKE_CURRENT_BINARY_DIR}/usr" CACHE PATH "Build prefix dir")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${JULIA_PREFIX_DIR}/${CMAKE_INSTALL_BINDIR}")
set(CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY "${JULIA_PREFIX_DIR}/${CMAKE_INSTALL_BINDIR}")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${JULIA_PREFIX_DIR}/${CMAKE_INSTALL_LIBDIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${JULIA_PREFIX_DIR}/${CMAKE_INSTALL_LIBDIR}")

set(JULIA_DEPOT_PATH "${JULIA_PREFIX_DIR}/${CMAKE_INSTALL_DATAROOTDIR}/julia")

set(CMAKE_DEBUG_SUFFIX "-debug")
#TODO: Disable library prefixes sometimes

if(WIN32)
    # add_compile_definitions("_OS_WINDOWS_") # Should probably be moved into a os configuration header instead. Windows typically defines _WIN32 (Note there is src/supports/platform.h)
    #add_compile_definitions("UNICODE" "_UNICODE")
    add_link_options(-STACK:8388608) # This setting should only be applied to the part which actually needs it?
endif()


# prefix ?= $(BUILDROOT)/julia-$(JULIA_COMMIT)
# ifeq ($(DARWIN_FRAMEWORK), 1)
# bindir := $(prefix)/$(framework_helpers)
# libdir := $(prefix)/$(framework_currver)
# libexecdir := $(prefix)/$(framework_helpers)
# datarootdir := $(prefix)/$(framework_resources)
# docdir := $(prefix)/$(framework_documentation)
# mandir := $(datarootdir)/man
# man1dir := $(mandir)/man1
# includedir := $(prefix)/$(framework_headers)
# sysconfdir := $(prefix)/$(framework_resources)
# else
# bindir := $(prefix)/bin
# libdir := $(prefix)/lib
# libexecdir := $(prefix)/libexec
# datarootdir := $(prefix)/share
# docdir := $(datarootdir)/doc/julia
# mandir := $(datarootdir)/man
# man1dir := $(mandir)/man1
# includedir := $(prefix)/include
# sysconfdir := $(prefix)/etc
# endif