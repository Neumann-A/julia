# This file is a part of Julia. License is MIT: https://julialang.org/license

## dummy stub for https://github.com/JuliaBinaryWrappers/MbedTLS_jll.jl

baremodule MbedTLS_jll
using Base, Libdl
Base.Experimental.@compiler_options compile=min optimize=0 infer=false

const PATH_list = String[]
const LIBPATH_list = String[]

# These get calculated in __init__()
const PATH = Ref("")
const LIBPATH = Ref("")
artifact_dir::String = ""
libmbedcrypto_handle::Ptr{Cvoid} = C_NULL
libmbedcrypto_path::String = ""
libmbedtls_handle::Ptr{Cvoid} = C_NULL
libmbedtls_path::String = ""
libmbedx509_handle::Ptr{Cvoid} = C_NULL
libmbedx509_path::String = ""

using Base.ExternalLibraryNames

function __init__()
    global libmbedcrypto_handle = dlopen(libmbedcrypto)
    global libmbedcrypto_path = dlpath(libmbedcrypto_handle)
    global libmbedtls_handle = dlopen(libmbedtls)
    global libmbedtls_path = dlpath(libmbedtls_handle)
    global libmbedx509_handle = dlopen(libmbedx509)
    global libmbedx509_path = dlpath(libmbedx509_handle)
    global artifact_dir = dirname(Sys.BINDIR)
    LIBPATH[] = dirname(libmbedtls_path)
    push!(LIBPATH_list, LIBPATH[])
end

# JLLWrappers API compatibility shims.  Note that not all of these will really make sense.
# For instance, `find_artifact_dir()` won't actually be the artifact directory, because
# there isn't one.  It instead returns the overall Julia prefix.
is_available() = true
find_artifact_dir() = artifact_dir
dev_jll() = error("stdlib JLLs cannot be dev'ed")
best_wrapper = nothing
get_libmbedcrypto_path() =libmbedcrypto_path
get_libmbedtls_path() = libmbedtls_path
get_libmbedx509_path() = libmbedx509_path

end  # module MbedTLS_jll
