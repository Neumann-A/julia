# TODO:
#   - prepare pcre_h.jl
#   - copy/link files into CMAKE_BINARY_DIR
#   - create sysimage

# $(BUILDDIR)/errno_h.jl:
# 	@$(call PRINT_PERL, echo '#include <errno.h>' | $(CPP) -dM - | perl -nle 'print "const $$1 = Int32($$2)" if /^#define\s+(E\w+)\s+(\d+)\s*$$/' | LC_ALL=C sort > $@)

# $(BUILDDIR)/file_constants.jl: $(SRCDIR)/../src/file_constants.h
# 	@$(call PRINT_PERL, $(CPP_STDOUT) -DJULIA $< | perl -nle 'print "$$1 0o$$2" if /^(\s*const\s+[A-z_]+\s+=)\s+(0[0-9]*)\s*$$/; print "$$1" if /^\s*(const\s+[A-z_]+\s+=\s+([1-9]|0x)[0-9A-z]*)\s*$$/' > $@)

# $(BUILDDIR)/uv_constants.jl: $(SRCDIR)/../src/uv_constants.h $(LIBUV_INC)/uv/errno.h
# 	@$(call PRINT_PERL, $(CPP_STDOUT) "-I$(LIBUV_INC)" -DJULIA $< | tail -n 16 > $@)

# $(BUILDDIR)/build_h.jl.phony:

find_package(PERL REQUIRED)
find_file(PCRE2_HEADER_FILE NAMES pcre2.h PATHS include)

set(JL_BASE_DIR "${CMAKE_BINARY_DIR}/share/julia/base")

add_custom_target(
    pcre_h
    COMMAND "${CMAKE_C_COMPILER}" -EP -d1PP
        "-D$<JOIN:$<TARGET_PROPERTY:julia,COMPILE_DEFINITIONS>,;-D>"
        "-I$<JOIN:$<TARGET_PROPERTY:julia,INCLUDE_DIRECTORIES>,;-I>"
        ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_${build_type}}
        $<TARGET_PROPERTY:julia,COMPILE_OPTIONS>
        "-DPCRE2_CODE_UNIT_WIDTH=8"
        "${PCRE2_HEADER_FILE}"
        | perl -nle [['/^\s*#define\s+PCRE2_(\w*)\s*\(?($(PCRE_CONST))\)?u?\s*$$/ and print index($$1, "ERROR_") == 0 ? "const $$1 = Cint($$2)" : "const $$1 = UInt32($$2)"']]
        | LC_ALL=C sort > "${JL_BASE_DIR}/pcre_h.jl"
    COMMAND_EXPAND_LISTS VERBATIM
    BYPRODUCTS "${JL_BASE_DIR}/pcre_h.jl"
    DEPENDS "${PCRE2_HEADER_FILE}"
    )
add_custom_target(
    uv_constants
    COMMAND "${CMAKE_C_COMPILER}" -EP -d1PP
        "-D$<JOIN:$<TARGET_PROPERTY:julia,COMPILE_DEFINITIONS>,;-D>"
        "-I$<JOIN:$<TARGET_PROPERTY:julia,INCLUDE_DIRECTORIES>,;-I>"
        ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_${build_type}}
        $<TARGET_PROPERTY:julia,COMPILE_OPTIONS>
        "-DJULIA"
        "${CMAKE_CURRENT_SOURCE_DIR}/../src/uv_constants.h"
        | tail -n 16 > "${JL_BASE_DIR}/uv_constants.jl"
    COMMAND_EXPAND_LISTS VERBATIM
    BYPRODUCTS "${JL_BASE_DIR}/uv_constants.jl"
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/../src/uv_constants.h"
    )

file(CREATE_LINK "${CMAKE_CURRENT_SOURCE_DIR}" "${JL_BASE_DIR}" COPY_ON_ERROR)

install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}" DESTINATION "share/julia/base")
install(TARGETS pcre_h uv_constants DESTINATION "share/julia/base")

set(BOOTSTRAP_DEBUG_LEVEL 2)
set(JULA_PRECOMPILE_DIR "${CMAKE_BINARY_DIR}/lib/julia")
set(JULIA_CPU_TARGET "x86_64")
add_custom_target(
    corecompiler_ji
    COMMAND julia_bin
        -C "${JULIA_CPU_TARGET}" --output-ji ${JULA_PRECOMPILE_DIR}/corecompiler.ji
        --startup-file=no --warn-overwrite=yes -g${BOOTSTRAP_DEBUG_LEVEL} 
        --trace-compile=stderr -O0 compiler/compiler.jl
    COMMAND_EXPAND_LISTS VERBATIM
    BYPRODUCTS "${JULA_PRECOMPILE_DIR}/corecompiler.ji"
    DEPENDS uv_constants pcre_h
)

add_custom_target(
    sys_ji
    COMMAND julia_bin
        -C "${JULIA_CPU_TARGET}" --output-ji "${JULA_PRECOMPILE_DIR}/sys.ji"
        ${JULIA_SYSIMG_BUILD_FLAGS}
        --startup-file=no --warn-overwrite=yes -g${BOOTSTRAP_DEBUG_LEVEL} 
        --trace-compile=stderr -O0 --sysimage "${JULA_PRECOMPILE_DIR}/corecompiler.ji" sysimg.jl
    COMMAND_EXPAND_LISTS VERBATIM
    BYPRODUCTS "${JULA_PRECOMPILE_DIR}/corecompiler.ji"
    DEPENDS uv_constants pcre_h
)
#JULIA_SYSIMG_BUILD_FLAGS
#RELBUILDROOT ?
