
# File to define platform and compiler independent options
include_guard(GLOBAL)
include(CMakeDependentOption)

option(JL_PRECOMPILE "Enable additional precompile (e.g. for the REPL)" ON)

option(JL_FORCE_ASSERTIONS "Enable assertions in the C and C++ portions of the Julia code base" ON)
# cmake_dependent_option(<option> "<help_text>" <value> <depends> <force>) LLVM_ASSERTIONS ?

option(JL_SYSTEM_DEPS_DEFAULT "Defines if system dependecies should be used by default (only works on first configure)" ON)
set(JL_DEPS 
        CSL LLVM PCRE LIBM LIBUNWIND DSFMT LIBBLASTRAMPOLINE BLAS LAPACK GMP MPFR
        LIBSUITESPARSE LIBUV UTF8PROC MBEDTLS LIBSSH2 NGHTTP2 CURL LIBGIT2 PATCHELF
        LIBWHICH ZLIB P7ZIP LLD
    )

foreach(dep IN LISTS JL_DEPS)
    option(USE_SYSTEM_${dep} "Use system ${dep}" "${JL_SYSTEM_DEP_DEFAULT}")
    set(USE_SYSTEM_${dep} "${USE_SYSTEM_${dep}}")
endforeach()

cmake_dependent_option(USE_SYSTUNTRUSTED_SYSTEM_LIBM "" OFF "USE_SYSTEM_LIBM" OFF)

option(DISABLE_LIBUNWIND "" OFF)
cmake_dependent_option(USE_SYSTEM_LIBUNWIND "" OFF "NOT DISABLE_LIBUNWIND" OFF)


