if(WIN32)
    add_compile_definitions("UNICODE" "_UNICODE")
endif()

set(jl_trampoline "")
if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/trampolines/trampolines_${JL_ARCH}.S")
    enable_language(ASM)
    add_library(julia_trampoline OBJECT "${CMAKE_CURRENT_LIST_DIR}/trampolines/trampolines_${JL_ARCH}.S")
    add_library(jl::trampoline ALIAS julia_trampoline)
    set(jl_trampoline "$<TARGET_OBJECTS:jl::trampoline>")
else()
    message(FATAL_ERROR "No trampoline for arch:${JL_ARCH}")
endif()

# TODO: Setup JL_DEP_LIBS with the correct file names. Probably a TARGET_FILENAME Genex
# TODO: Why is there a step stripping symbols? (Maybe due to exporting all symbols?)
if(WIN32)
    set(JL_DEP_LIBS "@$<TARGET_FILE_NAME:julia-internal>:@$<TARGET_FILE_NAME:julia-codegen>:")
else()
    set(JL_DEP_LIBS "@$../lib/<TARGET_FILE_NAME:julia-internal>:../lib/@$<TARGET_FILE_NAME:julia-codegen>:")
endif()

add_library(julia SHARED loader_lib.c jl_exports.h loader.h ${jl_trampoline})
add_library(jl::julia ALIAS julia)
target_compile_definitions(julia PRIVATE "JL_LIBRARY_EXPORTS" "DEP_LIBS=\"${JL_DEP_LIBS}\"" "LIBJULIA_NAME=\"$<TARGET_FILE_NAME:julia>\"")
target_include_directories(julia PUBLIC "../src/support")


add_executable(julia_bin loader_exe.c)
add_executable(jl::bin::julia ALIAS julia_bin)
set_target_properties(julia_bin PROPERTIES 
                        OUTPUT_NAME julia 
                        ARCHIVE_OUTPUT_NAME julia_exe_ar 
                        LIBRARY_OUTPUT_NAME julia_exe_lib
                    )
target_link_libraries(julia_bin PRIVATE jl::julia)
if(WIN32)
    target_sources(julia_bin PRIVATE "${CMAKE_SOURCE_DIR}/contrib/windows/julia.rc")
    target_compile_definitions(julia_bin PRIVATE "UNICODE" "_UNICODE")
endif()
target_compile_definitions(julia_bin PRIVATE "JLVER=${CMAKE_PROJECT_VERSION}" "JLVER_STR=${CMAKE_PROJECT_VERSION}" )


# LOADER_BUILD_DEP_LIBS = $(call build_deplibs, \
#     $(LIBGCC_BUILD_DEPLIB) \
#     $(LIBM_BUILD_DEPLIB) \
#     @$(LIBSTDCXX_BUILD_DEPLIB) \
#     @$(LIBJULIAINTERNAL_BUILD_DEPLIB) \
#     @$(LIBJULIACODEGEN_BUILD_DEPLIB) \
# )
# Are these really required?
#HEADERS := $(addprefix $(SRCDIR)/,jl_exports.h loader.h) $(addprefix $(JULIAHOME)/src/,julia_fasttls.h support/platform.h support/dirpath.h jl_exported_data.inc jl_exported_funcs.inc)
#LOADER_CFLAGS = $(JCFLAGS) -I$(BUILDROOT)/src -I$(JULIAHOME)/src -I$(JULIAHOME)/src/support -I$(build_includedir) -ffreestanding
#LOADER_LDFLAGS = $(JLDFLAGS) -ffreestanding -L$(build_shlibdir) -L$(build_libdir)
#ifeq ($(OS),WINNT)
#LOADER_CFLAGS += -municode -mconsole -nostdlib -fno-stack-check -fno-stack-protector -mno-stack-arg-probe
#else ifeq ($(OS),Linux)
#LOADER_CFLAGS += -DGLIBCXX_LEAST_VERSION_SYMBOL=\"$(shell echo "$(CSL_NEXT_GLIBCXX_VERSION)" | cut -d'|' -f1 | sed 's/\\//g')\"
#endif
