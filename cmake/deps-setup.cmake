include_guard(GLOBAL)

include(FeatureSummary)

#set(JL_DEPS 
#        CSL LLVM PCRE LIBM LIBUNWIND DSFMT LIBBLASTRAMPOLINE BLAS LAPACK GMP MPFR
#        LIBSUITESPARSE LIBUV UTF8PROC MBEDTLS LIBSSH2 NGHTTP2 CURL LIBGIT2 PATCHELF
#        LIBWHICH ZLIB P7ZIP LLD
#    )

if(USE_SYSTEM_LLVM OR TRUE)
    find_package(LLVM 15.0.7 COMPONENTS "LLVMDemangle;LLVMSupport;LLVMCodeGen;LLVMCore;LLVMX86CodeGen;LLVMX86AsmParser;LLVMAsmParser;LLVMMIRParser;LLVMOrcJIT;LLVMJITLink;LLVMX86Disassembler") # which componens are required ?
    add_library(jl::llvm INTERFACE IMPORTED)
    target_link_libraries(jl::llvm INTERFACE LLVMCore LLVMDemangle)
    add_library(jl::llvm-codegen INTERFACE IMPORTED)
    target_link_libraries(jl::llvm-codegen INTERFACE LLVMX86CodeGen LLVMX86Disassembler LLVMX86AsmParser LLVMAsmParser LLVMMIRParser LLVMOrcJIT LLVMJITLink)
else()
    # Vendor LLVM
endif()


if(PROJECT_IS_TOP_LEVEL)
    feature_summary(WHAT ENABLED_FEATURES DISABLED_FEATURES PACKAGES_FOUND)
    feature_summary(FILENAME ${CMAKE_CURRENT_BINARY_DIR}/features.log WHAT ALL)
endif()

# Setup dummy imported targets
# TODO: Make these real imported targets
find_path(UTF8PROC_INCLUDE_DIR NAMES utf8proc.h PATHS include)
find_library(UTF8PROC_LIBRARY NAMES utf8proc PATHS lib)

add_library(jl::utf8proc INTERFACE IMPORTED)
target_include_directories(jl::utf8proc INTERFACE "${UTF8PROC_INCLUDE_DIR}")
target_link_libraries(jl::utf8proc INTERFACE "${UTF8PROC_LIBRARY}")

find_path(GETOPT_INCLUDE_DIR NAMES getopt.h PATHS include)
find_library(GETOPT_LIBRARY NAMES getopt PATHS lib)

add_library(jl::getopt INTERFACE IMPORTED)
target_include_directories(jl::getopt INTERFACE "${GETOPT_INCLUDE_DIR}")
target_link_libraries(jl::getopt INTERFACE "${GETOPT_LIBRARY}")


find_path(LIBUV_INCLUDE_DIR NAMES uv.h PATHS include)
find_library(LIBUV_LIBRARY NAMES uv PATHS lib)
#TODO: DO checks if system libuv is useable. 
add_library(jl::libuv INTERFACE IMPORTED)
target_include_directories(jl::libuv INTERFACE "${LIBUV_INCLUDE_DIR}")
target_link_libraries(jl::libuv INTERFACE "${LIBUV_LIBRARY}")

add_library(jl::valgrind INTERFACE IMPORTED)
target_include_directories(jl::valgrind INTERFACE "${CMAKE_SOURCE_DIR}/deps/valgrind")

