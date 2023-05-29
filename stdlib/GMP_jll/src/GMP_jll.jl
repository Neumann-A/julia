# This file is a part of Julia. License is MIT: https://julialang.org/license

## dummy stub for https://github.com/JuliaBinaryWrappers/GMP_jll.jl
baremodule GMP_jll
using Base, Libdl
Base.Experimental.@compiler_options compile=min optimize=0 infer=false

const PATH_list = String[]
const LIBPATH_list = String[]

# These get calculated in __init__()
const PATH = Ref("")
const LIBPATH = Ref("")
artifact_dir::String = ""
libgmp_handle::Ptr{Cvoid} = C_NULL
libgmp_path::String = ""
libgmpxx_handle::Ptr{Cvoid} = C_NULL
libgmpxx_path::String = ""

using Base.ExternalLibraryNames

function __init__()
    global libgmp_handle = dlopen(libgmp)
    global libgmp_path = dlpath(libgmp_handle)
    global libgmpxx_handle = dlopen(libgmpxx)
    global libgmpxx_path = dlpath(libgmpxx_handle)
    global artifact_dir = dirname(Sys.BINDIR)
    LIBPATH[] = dirname(libgmp_path)
    push!(LIBPATH_list, LIBPATH[])
end

# JLLWrappers API compatibility shims.  Note that not all of these will really make sense.
# For instance, `find_artifact_dir()` won't actually be the artifact directory, because
# there isn't one.  It instead returns the overall Julia prefix.
is_available() = true
find_artifact_dir() = artifact_dir
dev_jll() = error("stdlib JLLs cannot be dev'ed")
best_wrapper = nothing
get_libgmp_path() = libgmp_path
get_libgmpxx_path() = libgmpxx_path

end  # module GMP_jll
