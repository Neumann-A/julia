include_guard(GLOBAL)

include(FeatureSummary)

set(JL_DEPS 
        CSL LLVM PCRE LIBM LIBUNWIND DSFMT LIBBLASTRAMPOLINE BLAS LAPACK GMP MPFR
        LIBSUITESPARSE LIBUV UTF8PROC MBEDTLS LIBSSH2 NGHTTP2 CURL LIBGIT2 PATCHELF
        LIBWHICH ZLIB P7ZIP LLD
    )

if(USE_SYSTEM_LLVM)
    find_package(LLVM 15.0.7 COMPONENTS "") # which componens are required ?
else()
    # Vendor LLVM
endif()


if(PROJECT_IS_TOP_LEVEL)
    feature_summary(WHAT ENABLED_FEATURES DISABLED_FEATURES PACKAGES_FOUND)
    feature_summary(FILENAME ${CMAKE_CURRENT_BINARY_DIR}/features.log WHAT ALL)
endif()

# Setup dummy imported targets
# TODO: Make these real imported targets
add_library(jl::utf8proc IMPORTED UNKNOWN)
add_library(jl::libuv IMPORTED UNKNOWN)
add_library(jl::llvm IMPORTED UNKNOWN)