# This file is a part of Julia. License is MIT: https://julialang.org/license

# external libnames
"""
    file containing the binding names for external dynamic libraries.
"""

baremodule ExternalLibraryNames

export  libuv,
        libpcre2,
        libutf8proc,    
        libuv,
        libgmp,
        libgmpxx,
        libmpfr,
        libdSFMT,
        libcurl,
        libgit2,
        libssh2,
        libmbedcrypto,
        libmbedtls,
        libmbedx509,
        libnghttp2,
        libopenblas,
        libopenlibm,
        libblastrampoline,
        libamd,
        libbtf,
        libcamd,
        libccolamd,
        libcholmod,
        libklu,
        libldl,
        librbio,
        libspqr,
        libsuitesparseconfig,
        libumfpack,
        libz

const libuv = "uv"
const libpcre2 = "pcre2-8"
const libutf8proc = "utf8proc"
const libuv = "uv"
const libgmp = "gmp-10"
const libgmpxx = "gmpxx-4"
const libmpfr = "mpfr-6"
const libdSFMT = "dSFMT"
const libcurl = "libcurl"
const libgit2 = "git2"
const libssh2 = "libssh2"

# NO DLL
const libmbedcrypto = "mbedcrypto"
const libmbedtls = "mbedtls"
const libmbedx509 = "mbedx509"

const libnghttp2 = "nghttp2"

const libopenblas = "mkl_rt.2.dll"
const libblastrampoline ="libblastrampoline-5" # NOTE: keep in sync with `Base.libblas_name` and `Base.liblapack_name`.

const libopenlibm = "" # TODO

const libamd = "libamd"
const libbtf = "libbtf"
const libcamd = "libcamd"
const libccolamd = "libccolamd"
const libcholmod = "libcholmod"
const libcolamd = "libcolamd"
const libklu = "libklu"
const libldl = "libldl"
const librbio = "librbio"
const libspqr = "libspqr"
const libsuitesparseconfig = "libsuitesparseconfig"
const libumfpack = "libumfpack"

const libz = "zlib1"

end