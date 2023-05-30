set(stdlib_ver 1.10)
# Hard links require that original exists and is a file


include(sysimage-builder)

include(FetchContent)
file(GLOB jl_stdlib_version_files "*.version")
foreach(jl_stdlib_version_file IN LISTS jl_stdlib_version_files)
    file(STRINGS "${jl_stdlib_version_file}" stdlib_version_info)
    cmake_path(GET jl_stdlib_version_file STEM stdlib_name)

    set(stdlib_git_url "${stdlib_version_info}")
    list(FILTER stdlib_git_url INCLUDE REGEX "_GIT_URL")
    string(REGEX REPLACE "[^=]+=[ \t]+" "" stdlib_git_url "${stdlib_git_url}")

    set(stdlib_sha1_ref "${stdlib_version_info}")
    list(FILTER stdlib_sha1_ref INCLUDE REGEX "_SHA1")
    string(REGEX REPLACE "[^=]+=[ \t]+" "" stdlib_sha1_ref "${stdlib_sha1_ref}")

    set(stdlib_branch "${stdlib_version_info}")
    list(FILTER stdlib_branch INCLUDE REGEX "_BRANCH")
    string(REGEX REPLACE "[^=]+=[ \t]+" "" stdlib_branch "${stdlib_branch}")

    string(TOLOWER "${stdlib_name}" stdlib_lower_name)

    #set(final_source_dir "${JULIA_DEPOT_PATH}/stdlib/v${stdlib_ver}/${stdlib_name}")
    set(final_source_dir "${CMAKE_CURRENT_SOURCE_DIR}/${stdlib_name}")

    #FetchContent_Declare(
    #    "JL_${stdlib_name}"
    #    GIT_REPOSITORY "${stdlib_git_url}"
    #    GIT_TAG        "${stdlib_sha1_ref}" 
    #    SOURCE_DIR     "${final_source_dir}"
    #)
    if(NOT EXISTS "${final_source_dir}/src/${stdlib_name}.jl")
      message(STATUS "Getting stdlib: '${stdlib_name}' from '${stdlib_git_url}' with ref '${stdlib_sha1_ref}' into '${final_source_dir}'")
      FetchContent_Populate(
        "JL_${stdlib_name}"
        GIT_REPOSITORY "${stdlib_git_url}"
        GIT_TAG        "${stdlib_sha1_ref}" 
        SOURCE_DIR     "${final_source_dir}"
      )
    else()
      message(STATUS "Skipping setup of stdlib: '${stdlib_name}' since it already exists")
    endif()
    #FetchContent_MakeAvailable("JL_${stdlib_name}")
    #FetchContent_GetProperties(JL_${stdlib_name})
    #if(NOT JL_${stdlib_name}_POPULATED AND NOT EXISTS "${final_source_dir}")
    #  message(STATUS "Populating content for stdlib: '${stdlib_name}' into '${final_source_dir}'")
    #  FetchContent_Populate("JL_${stdlib_name}")
    #else()
    #  message(STATUS "Skipping fetch content for stdlib: ${stdlib_name}")
    #endif()

endforeach()

file(COPY "${CMAKE_CURRENT_SOURCE_DIR}/" DESTINATION "${JULIA_DEPOT_PATH}/stdlib/v${stdlib_ver}/")

install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}" DESTINATION "${CMAKE_INSTALL_DATAROOTDIR}/julia/stdlib/v${stdlib_ver}")

set(jl_stdlib "ArgTools;Artifacts;Base64;CRC32c;FileWatching;Libdl;NetworkOptions;SHA;Serialization;
		GMP_jll;LLVMLibUnwind_jll;LibUV_jll;LibUnwind_jll;MbedTLS_jll;OpenLibm_jll;PCRE2_jll;
		Zlib_jll;dSFMT_jll;libLLVM_jll;libblastrampoline_jll;OpenBLAS_jll;Printf;Random;Tar;
		LibSSH2_jll;MPFR_jll;LinearAlgebra;Dates;Distributed;Future;LibGit2;Profile;SparseArrays;UUIDs;
		SharedArrays;TOML;Test;LibCURL;Downloads;Pkg;Dates;LazyArtifacts;Sockets;Unicode;Markdown;
		InteractiveUtils;REPL;DelimitedFiles"
)

#;TODO:;compile;stdlib