# This file is a part of Julia. License is MIT: https://julialang.org/license

## dummy stub for https://github.com/JuliaBinaryWrappers/SuiteSparse_jll.jl
baremodule SuiteSparse_jll
using Base, Libdl, libblastrampoline_jll
Base.Experimental.@compiler_options compile=min optimize=0 infer=false

const PATH_list = String[]
const LIBPATH_list = String[]

# These get calculated in __init__()
# Man I can't wait until these are automatically handled by an in-Base JLLWrappers clone.
const PATH = Ref("")
const LIBPATH = Ref("")
artifact_dir::String = ""
libamd_handle::Ptr{Cvoid} = C_NULL
libamd_path::String = ""
libbtf_handle::Ptr{Cvoid} = C_NULL
libbtf_path::String = ""
libcamd_handle::Ptr{Cvoid} = C_NULL
libcamd_path::String = ""
libccolamd_handle::Ptr{Cvoid} = C_NULL
libccolamd_path::String = ""
libcholmod_handle::Ptr{Cvoid} = C_NULL
libcholmod_path::String = ""
libcolamd_handle::Ptr{Cvoid} = C_NULL
libcolamd_path::String = ""
libklu_handle::Ptr{Cvoid} = C_NULL
libklu_path::String = ""
libldl_handle::Ptr{Cvoid} = C_NULL
libldl_path::String = ""
librbio_handle::Ptr{Cvoid} = C_NULL
librbio_path::String = ""
libspqr_handle::Ptr{Cvoid} = C_NULL
libspqr_path::String = ""
libsuitesparseconfig_handle::Ptr{Cvoid} = C_NULL
libsuitesparseconfig_path::String = ""
libumfpack_handle::Ptr{Cvoid} = C_NULL
libumfpack_path::String = ""

using Base.ExternalLibraryNames

function __init__()
    global libamd_handle = dlopen(libamd)
    global libamd_path = dlpath(libamd_handle)
    global libbtf_handle = dlopen(libbtf)
    global libbtf_path = dlpath(libbtf_handle)
    global libcamd_handle = dlopen(libcamd)
    global libcamd_path = dlpath(libcamd_handle)
    global libccolamd_handle = dlopen(libccolamd)
    global libccolamd_path = dlpath(libccolamd_handle)
    global libcholmod_handle = dlopen(libcholmod)
    global libcholmod_path = dlpath(libcholmod_handle)
    global libcolamd_handle = dlopen(libcolamd)
    global libcolamd_path = dlpath(libcolamd_handle)
    global libklu_handle = dlopen(libklu)
    global libklu_path = dlpath(libklu_handle)
    global libldl_handle = dlopen(libldl)
    global libldl_path = dlpath(libldl_handle)
    global librbio_handle = dlopen(librbio)
    global librbio_path = dlpath(librbio_handle)
    global libspqr_handle = dlopen(libspqr)
    global libspqr_path = dlpath(libspqr_handle)
    global libsuitesparseconfig_handle = dlopen(libsuitesparseconfig)
    global libsuitesparseconfig_path = dlpath(libsuitesparseconfig_handle)
    global libumfpack_handle = dlopen(libumfpack)
    global libumfpack_path = dlpath(libumfpack_handle)
    global artifact_dir = dirname(Sys.BINDIR)
end

# JLLWrappers API compatibility shims.  Note that not all of these will really make sense.
# For instance, `find_artifact_dir()` won't actually be the artifact directory, because
# there isn't one.  It instead returns the overall Julia prefix.
is_available() = true
find_artifact_dir() = artifact_dir
dev_jll() = error("stdlib JLLs cannot be dev'ed")
best_wrapper = nothing
get_libamd_path() = libamd_path
get_libbtf_path() = libbtf_path
get_libcamd_path() = libcamd_path
get_libccolamd_path() = libccolamd_path
get_libcholmod_path() = libcholmod_path
get_libcolamd_path() = libcolamd_path
get_libklu_path() = libklu_path
get_libldl_path() = libldl_path
get_librbio_path() = librbio_path
get_libspqr_path() = libspqr_path
get_libsuitesparseconfig_path() = libsuitesparseconfig_path
get_libumfpack_path() = libumfpack_path

end  # module SuiteSparse_jll
