add_subdirectory(support)
add_subdirectory(flisp)


# JL_LIBJULIA_SONAME=\"$(LIBJULIA_PATH_REL).$(JL_MAJOR_SHLIB_EXT)\

# $(build_shlibdir)/libccalltest.$(SHLIB_EXT): $(SRCDIR)/ccalltest.c
# $(build_shlibdir)/libllvmcalltest.$(SHLIB_EXT): $(SRCDIR)/llvmcalltest.cpp $(LLVM_CONFIG_ABSOLUTE) 

# $(BUILDDIR)/julia_flisp.boot: $(addprefix $(SRCDIR)/,jlfrontend.scm flisp/aliases.scm flisp/profile.scm \
#julia-parser.scm julia-syntax.scm match.scm utils.scm ast.scm macroexpand.scm mk_julia_flisp_boot.scm) \
#$(FLISP_EXECUTABLE_release)
#@$(call PRINT_FLISP, $(call spawn,$(FLISP_EXECUTABLE_release)) \
#$(call cygpath_w,$(SRCDIR)/mk_julia_flisp_boot.scm) $(call cygpath_w,$(dir $<)) $(notdir $<) $(call cygpath_w,$@))

#$(build_shlibdir)/lib%Plugin.$(SHLIB_EXT): $(SRCDIR)/clangsa/%.cpp $(LLVM_CONFIG_ABSOLUTE)
#	@$(call PRINT_CC, $(CXX) -g $(fPIC) -shared -o $@ -DCLANG_PLUGIN -I$(build_includedir) -L$(build_libdir) \
#		$(LLVM_CXXFLAGS) $(CLANG_LDFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) $(CXXLDFLAGS) $<)

# -DJULIA_NUM_THREADS=1 -DJL_DISABLE_LIBUNWIND

set(JL_IS_RELEASE 1)

file(STRINGS "jl_exported_funcs.inc" jl_exported_funcs REGEX "XX\\\(([^)]+)\\\)")
string(REPLACE "\\" "" jl_exported_funcs "${jl_exported_funcs}")
list(TRANSFORM jl_exported_funcs STRIP)
list(TRANSFORM jl_exported_funcs REPLACE "XX\\\(([^)]+)\\\)" "#define \\1 i\\1")
list(JOIN jl_exported_funcs "\n" jl_internal_funcs)
file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/jl_internal_funcs.inc" "${jl_internal_funcs}")

configure_file("julia_version.h.in" "${CMAKE_CURRENT_BINARY_DIR}/julia_version.h" @ONLY)

set(jl_internal
       "jltypes;gf;typemap;smallintset;ast;builtins;module;interpreter;symbol"
       "dlload;sys;init;task;array;staticdata;toplevel;jl_uv;datatype"
       "simplevector;runtime_intrinsics;precompile;jloptions"
       "threading;partr;stackwalk;gc;gc-debug;gc-pages;gc-stacks;gc-alloc-profiler;method"
       "jlapi;signal-handling;safepoint;timing;subtype;rtutils;gc-heap-snapshot"
       "crc32c;APInt-C;processor;ircode;opaque_closure;codegen-stubs;coverage;runtime_ccall"
   )

if(WIN32)
    list(APPEND jl_internal win32_ucontext)
endif()
set(jl_internal_srcs "")
foreach(file IN LISTS jl_internal) # TODO better directly set the names
    foreach(suffix IN ITEMS c cpp h hpp)
        if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${file}.${suffix}")
            list(APPEND jl_internal_srcs "${file}.${suffix}")
            break()
        endif()
    endforeach()
endforeach()

add_library(julia-internal SHARED ${jl_internal_srcs} ${jl_internal_proc_srcs} ${jl_internal_signals_srcs} $<TARGET_OBJECTS:support> $<TARGET_OBJECTS:setjmp_impl>)
add_library(jl::julia-internal ALIAS julia-internal)
target_link_libraries(julia-internal PRIVATE jl::julia jl::flisp jl::libuv jl::valgrind jl::getopt jl::llvm)
if(WIN32)
    target_link_libraries(julia-internal PRIVATE Dbghelp.lib Winmm.lib Ws2_32.lib)
endif()
target_compile_definitions(julia-internal PRIVATE 
                                "JL_LIBRARY_EXPORTS_INTERNAL"
                                "JL_BUILD_ARCH=\"${JL_ARCH}\""
                                "JL_BUILD_UNAME=\"NT\"" # TODO fix this
                                "JL_SYSTEM_IMAGE_PATH=\"../lib/julia/${CMAKE_SHARED_LIBRARY_PREFIX}sys${CMAKE_SHARED_LIBRARY_SUFFIX}\"" # TODO needs this to be variable?
                                "JL_LIBJULIA_SONAME=\"$<TARGET_FILE_NAME:julia>\""
                                "JL_DISABLE_LIBUNWIND" # TODO fix this
                           )
target_include_directories(julia-internal PRIVATE "support" "flisp")
target_include_directories(julia-internal PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>")
#target_compile_options(julia-internal PRIVATE "-U_UNICODE" "-UUNICODE") only cli really unicode?

if(MSVC)
 #MSVC has no real 128bit intrinsics so take them from llvm
target_link_libraries(julia-internal PRIVATE clang_rt.builtins-x86_64.lib)
target_link_options(julia-internal PRIVATE
                        -NODEFAULTLIB:libcmt
                        -export:__udivti3=__udivti3
                        -export:__divti3=__divti3
                        -export:__umodti3=__umodti3
                        -export:__modti3=__modti3
                    )
endif()

add_dependencies(julia-internal gen_julia_flisp_boot_inc)

set(jl_codegen
     "codegen;jitlayers;aotcompile;debuginfo;disasm;llvm-simdloop;llvm-muladd"
     "llvm-final-gc-lowering;llvm-pass-helpers;llvm-late-gc-lowering;llvm-ptls"
     "llvm-lower-handlers;llvm-gc-invariant-verifier;llvm-propagate-addrspaces"
     "llvm-multiversioning;llvm-alloc-opt;llvm-alloc-helpers;cgmemmgr;llvm-remove-addrspaces"
     "llvm-remove-ni;llvm-julia-licm;llvm-demote-float16;llvm-cpufeatures;pipeline;llvm_api"
)

set(jl_codegen_srcs "")
foreach(file IN LISTS jl_codegen)  # TODO better directly set the names
    foreach(suffix IN ITEMS c cpp h hpp)
        if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${file}.${suffix}")
            list(APPEND jl_codegen_srcs "${file}.${suffix}")
            break()
        endif()
    endforeach()
endforeach()
add_library(julia-codegen SHARED ${jl_codegen_srcs} ${jl_codegen_abi_srcs})
add_library(jl::julia-codegen ALIAS julia-codegen)
target_link_libraries(julia-codegen PRIVATE jl::julia-internal jl::julia jl::llvm jl::llvm-codegen jl::libuv)
if(WIN32)
    target_link_libraries(julia-codegen PRIVATE Dbghelp.lib)
endif()
target_compile_definitions(julia-codegen PRIVATE 
                                "JL_LIBRARY_EXPORTS_CODEGEN"
                                "JL_BUILD_ARCH=\"${JL_ARCH}\""
                                "JL_BUILD_UNAME=\"NT\"" # TODO fix this
                                "JL_SYSTEM_IMAGE_PATH=\"../lib/julia/${CMAKE_SHARED_LIBRARY_PREFIX}sys${CMAKE_SHARED_LIBRARY_SUFFIX}\"" # TODO needs this to be variable?
                                "JL_LIBJULIA_SONAME=\"$<TARGET_FILE_NAME:julia>\""
                                "JL_DISABLE_LIBUNWIND" # TODO fix this
                            )
target_include_directories(julia-internal PRIVATE "support")


# TODO: Figure out what headers to install?