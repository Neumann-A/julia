


set(JL_DIR_SEP "/")
if(WIN32)
#    set(JL_DIR_SEP "\\\\")
endif()
#JULIAHOME
# JULIA_DEPOT_PATH is share/julia
set(JL_BASE_DIR "${JULIA_DEPOT_PATH}/base")
set(JL_TMP_DIR "${JULIA_DEPOT_PATH}/tmp")
file(MAKE_DIRECTORY "${JL_TMP_DIR}")
file(COPY "${CMAKE_CURRENT_SOURCE_DIR}/." DESTINATION  "${JL_BASE_DIR}/")

if(NOT Darwin)
    set(JL_DARWIN_FRAMEWORK false)
endif()
set(JL_USE_GPL_LIBS true)
set(JL_USE_BLAS64 false)
set(JL_LIBM "")
set(LLVM_SHARED_LIB_NAME "LLVM-C")
configure_file("${JL_BASE_DIR}/build_h.jl.in" "${JL_BASE_DIR}/build_h.jl" @ONLY)

set(jl_null_redirect null)

set(JL_COMMIT "")
set(JL_COMMIT_SHORT "") 
set(JL_BRANCH "") 
set(JL_BUILD_NUMBER -1) 
set(JL_BUILD_DATE "")
set(JL_TAGGED false) 
set(JL_FORK_MASTER_DIST -1) 
set(JL_FORK_MASTER_TIMESTAMP 0.0) 
set(JL_BUILD_SYSTEM_COMMIT "")
set(JL_BUILD_SYSTEM_COMMIT_SHORT "")
if(Git_FOUND)
    set(GIT_COMMAND_ECHO "STDOUT")
    macro(jl_run_git_command command outvar)
        separate_arguments(command_list NATIVE_COMMAND "${command}")
        execute_process(COMMAND ${GIT_EXECUTABLE} ${command_list}
            WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/.."
            COMMAND_ERROR_IS_FATAL LAST
            COMMAND_ECHO ${GIT_COMMAND_ECHO}
            OUTPUT_VARIABLE ${outvar} 
            ${ARGN})
    endmacro()
    jl_run_git_command("config -l" "origin")
    string(REPLACE "\n" ";" origin "${origin}")
    list(FILTER origin INCLUDE REGEX "remote\\\.(url\\\.|[^.]+\\\.)+.+/julia\\\.git")
    if(origin)
        string(REGEX REPLACE "remote\\\.([a-zA-Z]+).+" "\\1/" origin "${origin}")
    else()
        set(origin "origin/")
    endif()
    jl_run_git_command("rev-parse HEAD" "JL_COMMIT")
    jl_run_git_command("rev-parse --short HEAD" "JL_COMMIT_SHORT")
    jl_run_git_command("status --porcelain" "GIT_IS_CLEAN")
    if(NOT GIT_IS_CLEAN)
        string(APPEND JL_COMMIT_SHORT "*")
    endif()
    if(DEFINED ENV{BUILDKITE_BRANCH})
        set(JL_BRANCH "$ENV{BUILDKITE_BRANCH}")
    else()
        jl_run_git_command("rev-parse --abbrev-ref HEAD" "JL_BRANCH")
    endif()
    jl_run_git_command("rev-parse --show-toplevel" "GIT_TOPDIR" OUTPUT_STRIP_TRAILING_WHITESPACE)
    string(REPLACE "\n" "" GIT_TOPDIR "${GIT_TOPDIR}")
    jl_run_git_command("blame -L ,1 -sl -- \"${GIT_TOPDIR}/VERSION\"" "GIT_JL_VERSION")
    if(GIT_JL_VERSION MATCHES "^(0000000000000000000000000000000000000000)")
        set(JL_BUILD_NUMBER 0)
    else()
        string(REGEX REPLACE " .+" "" GIT_JL_VERSION "${GIT_JL_VERSION}")
        jl_run_git_command("rev-list --count HEAD \"${GIT_JL_VERSION}\"" "GIT_VERSION")
    endif()
    jl_run_git_command("log -1 --pretty=format:%ci" "JL_BUILD_DATE")
    #jl_run_git_command("describe --tags --exact-match" "GIT_JL_TAGGED" ERROR_QUIET COMMAND echo 0)
    #if(NOT GIT_JL_TAGGED)
    #    set(JL_TAGGED false)
    #endif()
    #TODO
    #fork_master_distance=$(git rev-list HEAD ^"$(echo $origin)master" | wc -l | sed -e 's/[^[:digit:]]//g')
    #fork_master_timestamp=$(git show -s $(git merge-base HEAD $(echo $origin)master) --format=format:"%ct")
    set(buildkite_dir "${CMAKE_CURRENT_SOURCE_DIR}/../.buildkite")
    if(EXISTS "${buildkite_dir}/.git") 
        jl_run_git_command("-C \"${buildkite_dir}\" rev-parse HEAD" "JL_BUILD_SYSTEM_COMMIT")
        jl_run_git_command("-C \"${buildkite_dir}\" rev-parse --short HEAD" "JL_BUILD_SYSTEM_COMMIT_SHORT")
    endif()
endif()

configure_file("${JL_BASE_DIR}/version_git.jl.in" "${JL_BASE_DIR}/version_git.jl" @ONLY) # TODO

separate_arguments(cpp_flags NATIVE_COMMAND "${CMAKE_C_FLAGS}")
separate_arguments(cpp_flags_${build_type} NATIVE_COMMAND "${CMAKE_C_FLAGS_${build_type}}")

set(CALL_C_PREPROCESSOR "${CMAKE_C_COMPILER}" -EP -d1PP)

find_file(PCRE2_HEADER_FILE NAMES pcre2.h PATHS include)
add_custom_target(
    pcre_h ALL
    COMMAND "${CALL_C_PREPROCESSOR}"
        ${cpp_flags} ${cpp_flags_${build_type}}
        "-D$<JOIN:$<TARGET_PROPERTY:julia,COMPILE_DEFINITIONS>,;-D>"
        "-I$<JOIN:$<TARGET_PROPERTY:julia,INCLUDE_DIRECTORIES>,;-I>"
        "-DPCRE2_CODE_UNIT_WIDTH=8"
        "${PCRE2_HEADER_FILE}"
        > "${JL_TMP_DIR}/pcre_h.jl.tmp"
    COMMAND "${CMAKE_COMMAND}"
        "-DINPUT=${JL_TMP_DIR}/pcre_h.jl.tmp"
        "-DOUTPUT=${JL_BASE_DIR}/pcre_h.jl"
        -P "${CMAKE_CURRENT_SOURCE_DIR}/../cmake/pcre_h_jl.cmake" 
    COMMAND_EXPAND_LISTS VERBATIM
    BYPRODUCTS "${JL_BASE_DIR}/pcre_h.jl"
    DEPENDS "${PCRE2_HEADER_FILE}"
)

add_custom_target(
    uv_constants ALL
    COMMAND "${CALL_C_PREPROCESSOR}"
        ${cpp_flags} ${cpp_flags_${build_type}}
        "-D$<JOIN:$<TARGET_PROPERTY:julia,COMPILE_DEFINITIONS>,;-D>"
        "-I$<JOIN:$<TARGET_PROPERTY:julia,INCLUDE_DIRECTORIES>,;-I>"
        "-I$<JOIN:$<TARGET_PROPERTY:jl::libuv,INTERFACE_INCLUDE_DIRECTORIES>,;-I>"
        "-DJULIA"
        "${CMAKE_CURRENT_SOURCE_DIR}/../src/uv_constants.h"
        > "${JL_TMP_DIR}/uv_constants.jl.tmp"
    COMMAND "${CMAKE_COMMAND}"
        "-DINPUT=${JL_TMP_DIR}/uv_constants.jl.tmp"
        "-DOUTPUT=${JL_BASE_DIR}/uv_constants.jl"
        "-DLINES=16"
        -P "${CMAKE_CURRENT_SOURCE_DIR}/../cmake/tail.cmake" 
    COMMAND_EXPAND_LISTS VERBATIM
    BYPRODUCTS "${JL_BASE_DIR}/uv_constants.jl"
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/../src/uv_constants.h"
)

file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/errno-jl.h" "#include <errno.h>")
add_custom_target(
    errno ALL
    COMMAND "${CALL_C_PREPROCESSOR}"
        ${cpp_flags} ${cpp_flags_${build_type}}
        "-D$<JOIN:$<TARGET_PROPERTY:julia,COMPILE_DEFINITIONS>,;-D>"
        "${CMAKE_CURRENT_BINARY_DIR}/errno-jl.h"
        > "${JL_TMP_DIR}/errno_h.jl.tmp"
    COMMAND ${CMAKE_COMMAND} 
        "-DINPUT=${JL_TMP_DIR}/errno_h.jl.tmp"
        "-DOUTPUT=${JL_BASE_DIR}/errno_h.jl"
        -P "${CMAKE_CURRENT_SOURCE_DIR}/../cmake/errno_h_jl.cmake" 
    COMMAND_EXPAND_LISTS VERBATIM
    BYPRODUCTS "${JL_BASE_DIR}/errno_h.jl"
)

add_custom_target(
    file_constants ALL
    COMMAND "${CALL_C_PREPROCESSOR}"
        ${cpp_flags} ${cpp_flags_${build_type}}
        "-D$<JOIN:$<TARGET_PROPERTY:julia,COMPILE_DEFINITIONS>,;-D>"
        "-DJULIA"
        "${CMAKE_CURRENT_SOURCE_DIR}/../src/file_constants.h"
        > "${JL_TMP_DIR}/file_constants.jl.tmp"
    COMMAND ${CMAKE_COMMAND} 
        "-DINPUT=${JL_TMP_DIR}/file_constants.jl.tmp"
        "-DOUTPUT=${JL_BASE_DIR}/file_constants.jl"
        -P "${CMAKE_CURRENT_SOURCE_DIR}/../cmake/file_constants_jl.cmake" 
    COMMAND_EXPAND_LISTS VERBATIM
    BYPRODUCTS "${JL_BASE_DIR}/file_constants.jl"
)

set(JL_ARCHS X86 AArch32 AArch64)
set(final_contents "# This file is autogenerated by CMake")
foreach(arch IN LISTS JL_ARCHS)
    string(TOLOWER "${arch}" archl)
    set(feat_file "${CMAKE_CURRENT_SOURCE_DIR}/../src/features_${archl}.h")
    set(contents "")
    file(STRINGS "${feat_file}" contents REGEX "^JL_FEATURE_DEF") # also filters commented sections
    list(TRANSFORM contents 
         REPLACE 
            "^JL_FEATURE_DEF(_NAME)?\\\(([^,]+),[ \t]*([^,]+),.+" 
            "const JL_${arch}_\\2 = UInt32(\\3)"
        )
    list(JOIN contents "\n" contents_new)
    string(APPEND final_contents "\n# ${arch} features\n" "${contents_new}\n" )
endforeach()
file(WRITE "${JL_BASE_DIR}/features_h.jl" "${final_contents}\n")


install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/" DESTINATION "share/julia/base")
install(FILES 
            "${JL_BASE_DIR}/pcre_h.jl"
            "${JL_BASE_DIR}/uv_constants.jl"
            "${JL_BASE_DIR}/errno_h.jl"
            "${JL_BASE_DIR}/file_constants.jl"
            "${JL_BASE_DIR}/features_h.jl"
            "${JL_BASE_DIR}/build_h.jl"
            "${JL_BASE_DIR}/version_git.jl"
        DESTINATION 
            "share/julia/base")


set(JULA_PRECOMPILE_DIR "${JULIA_PREFIX_DIR}/${CMAKE_INSTALL_LIBDIR}/julia")
file(MAKE_DIRECTORY "${JULA_PRECOMPILE_DIR}")

set(JULIA_CPU_TARGET "x86_64")
set(BOOTSTRAP_DEBUG_LEVEL 1)

add_custom_target(
    corecompiler_ji ALL
    COMMAND echo "Compiling corecompiler.ji"
    COMMAND julia_bin
        -C "${JULIA_CPU_TARGET}" 
        --output-ji "${JULA_PRECOMPILE_DIR}/corecompiler.ji"
        --startup-file=no 
        --warn-overwrite=yes 
        -g${BOOTSTRAP_DEBUG_LEVEL}
        --trace-compile=stderr 
        -O0 
        "${JL_BASE_DIR}/compiler/compiler.jl"
    COMMAND echo "Finished corecompiler.ji"
    COMMAND_EXPAND_LISTS VERBATIM USES_TERMINAL
    BYPRODUCTS "${JULA_PRECOMPILE_DIR}/corecompiler.ji"
    WORKING_DIRECTORY "${JL_BASE_DIR}"
    DEPENDS uv_constants file_constants pcre_h errno julia-codegen
)

add_custom_target(
    sys_o0_ji ALL
    COMMAND echo "Running sysimg.ji"
    COMMAND set JULIA_NUM_THREADS=1
    COMMAND julia_bin
        -C "${JULIA_CPU_TARGET}" 
        --output-ji "${JULA_PRECOMPILE_DIR}/sys-o0.ji"
        ${JULIA_SYSIMG_BUILD_FLAGS}
        --startup-file=no
        --warn-overwrite=yes
        -g${BOOTSTRAP_DEBUG_LEVEL}
        --trace-compile=stderr
        -O0 # is there a reason not to run this with O
        --sysimage "${JULA_PRECOMPILE_DIR}/corecompiler.ji" sysimg.jl "${JL_BASE_DIR}/"
    COMMAND echo "Finished sysimg.jl"
    COMMAND_EXPAND_LISTS VERBATIM USES_TERMINAL
    BYPRODUCTS "${JULA_PRECOMPILE_DIR}/sys-o0.ji"
    WORKING_DIRECTORY "${JL_BASE_DIR}"
    DEPENDS corecompiler_ji
)

install(FILES "${JULA_PRECOMPILE_DIR}/sys-o0.ji" DESTINATION "${CMAKE_INSTALL_LIBDIR}/julia")

add_custom_target(
    sysimg_builder_ji 
    COMMAND echo "Running generate_precompile.jl for sys.ji"
    COMMAND set JULIA_NUM_THREADS=1
    COMMAND julia_bin
        -C "${JULIA_CPU_TARGET}" 
        --output-ji "${JULA_PRECOMPILE_DIR}/sys.ji"
        ${JULIA_SYSIMG_BUILD_FLAGS}
        --startup-file=no 
        --warn-overwrite=yes 
        -g${BOOTSTRAP_DEBUG_LEVEL} 
        --trace-compile=stderr 
        -O3
        --sysimage "${JULA_PRECOMPILE_DIR}/sys-o0.ji" 
        "${CMAKE_CURRENT_SOURCE_DIR}/../contrib/generate_precompile.jl"
    COMMAND echo "Finished generate_precompile.jl"
    COMMAND_EXPAND_LISTS VERBATIM USES_TERMINAL
    BYPRODUCTS "${JULA_PRECOMPILE_DIR}/sys.ji"
    WORKING_DIRECTORY "${JL_BASE_DIR}"
    DEPENDS sys_o0_ji
)

#install(FILES "${JULA_PRECOMPILE_DIR}/sys.ji" DESTINATION "${CMAKE_INSTALL_LIBDIR}/julia")

add_custom_target(
    sysimg_builder_o ALL
    COMMAND echo "Running generate_precompile.jl for sys.o"
    COMMAND set JULIA_NUM_THREADS=1
    COMMAND julia_bin
        -C "${JULIA_CPU_TARGET}" 
        --output-o "${JULA_PRECOMPILE_DIR}/sys${CMAKE_C_OUTPUT_EXTENSION}"
        ${JULIA_SYSIMG_BUILD_FLAGS}
        --startup-file=no 
        --warn-overwrite=yes 
        -g${BOOTSTRAP_DEBUG_LEVEL} 
        --trace-compile=stderr 
        -O0
        --sysimage "${JULA_PRECOMPILE_DIR}/sys-o0.ji" 
        "${CMAKE_CURRENT_SOURCE_DIR}/../contrib/generate_precompile.jl"
    COMMAND echo "Finished generate_precompile.jl"
    COMMAND_EXPAND_LISTS VERBATIM USES_TERMINAL
    BYPRODUCTS "${JULA_PRECOMPILE_DIR}/sys${CMAKE_C_OUTPUT_EXTENSION}"
    WORKING_DIRECTORY "${JL_BASE_DIR}"
    DEPENDS sys_o0_ji
)

separate_arguments(c_linker_flags NATIVE_COMMAND "${CMAKE_SHARED_LINKER_FLAGS}")
separate_arguments(c_linker_flags_${build_type} NATIVE_COMMAND "${CMAKE_SHARED_LINKER_FLAGS_${build_type}}")

string(REPLACE "<LIBRARY>" "" whole_archive "${CMAKE_LINK_LIBRARY_USING_WHOLE_ARCHIVE}")

add_library(sys SHARED "${JULA_PRECOMPILE_DIR}/sys${CMAKE_C_OUTPUT_EXTENSION}")
add_dependencies(sys sysimg_builder_o)
target_link_libraries(sys PRIVATE julia julia-internal julia-codegen)
target_compile_options(sys PRIVATE -fuse-ld=lld)
target_link_options(sys PRIVATE  
                               # /DEFAULTLIB:libucrt.lib 
                               # /DEFAULTLIB:libvcruntime.lib
                               # /DEFAULTLIB:libcmt.lib
                               # /DEFAULTLIB:oldnames.lib 
 )
set_property(TARGET sys PROPERTY
  MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
set_target_properties(sys PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(sys PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${JULA_PRECOMPILE_DIR}")
# add_custom_target(
#     sys_shared ALL
#     COMMAND ${CMAKE_LINKER}
#         ${c_linker_flags} 
#         ${c_linker_flags_${build_type}}
#         /DLL
#         "/out:${JULA_PRECOMPILE_DIR}/sys.dll"
#         #"/pdb:${JULA_PRECOMPILE_DIR}/sys.pdb"
#         /DEFAULTLIB:msvcrt.lib
#         /DEFAULTLIB:oldnames.lib
#         "${CMAKE_LIBRARY_PATH_FLAG}${JULA_PRECOMPILE_DIR}"
#         "${CMAKE_LIBRARY_PATH_FLAG}${CMAKE_LIBRARY_OUTPUT_DIRECTORY}" # Could also use $<TARGET_LINKER_FILE_DIR:tgt>
#         "${whole_archive}${JULA_PRECOMPILE_DIR}/sys.obj"
#         "${CMAKE_LINK_LIBRARY_FLAG}$<TARGET_LINKER_FILE:julia>"
#         "${CMAKE_LINK_LIBRARY_FLAG}$<TARGET_LINKER_FILE:julia-internal>"
#         "${CMAKE_LINK_LIBRARY_FLAG}$<TARGET_LINKER_FILE:julia-codegen>"
#         #-g${BOOTSTRAP_DEBUG_LEVEL} 
#         #--trace-compile=stderr 
#     COMMAND_EXPAND_LISTS VERBATIM
#     BYPRODUCTS "${JULA_PRECOMPILE_DIR}/sys.dll"
#     WORKING_DIRECTORY "${JL_BASE_DIR}"
#     DEPENDS sysimg_builder julia julia-internal
# )

install(FILES "${JULA_PRECOMPILE_DIR}/sys.dll" DESTINATION "${CMAKE_INSTALL_LIBDIR}/julia")
