cmake_minimum_required(VERSION 3.21)

include(CMakePrintHelpers)

list(PREPEND CMAKE_MODULE_PATH 
                "${CMAKE_CURRENT_LIST_DIR}/cmake/modules"
                "${CMAKE_CURRENT_LIST_DIR}/cmake"
    )

include(options)
include(select-default-toolchain)

project(Julia 
        VERSION 1.10
        DESCRIPTION "Julia is a high-level, high-performance dynamic language for technical computing."
        HOMEPAGE_URL "julialang.org"
        LANGUAGES C CXX #ASM
        )

include(GNUInstallDirs)

if(PROJECT_IS_TOP_LEVEL)
    include(CTest)
endif()

include(general-setup)
include(options-platform)
include(platform-setup)
include(deps-setup)

add_subdirectory(cli)
add_subdirectory(src)
add_subdirectory(base)

#TODO: add global install rules.