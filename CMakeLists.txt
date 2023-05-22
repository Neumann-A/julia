cmake_minimum_required(VERSION 3.21)

include(CMakePrintHelpers)

list(PREPEND CMAKE_MODULE_PATH 
                "${CMAKE_CURRENT_LIST_DIR}/cmake/modules"
                "${CMAKE_CURRENT_LIST_DIR}/cmake"
    )

include(options)
include(select-default-toolchain)

project(Julia 
        VERSION 1.10.0
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

# Compile sysimage

add_subdirectory(stdlib)
#TODO: add global install rules.


install(TARGETS julia
                julia_bin
                julia-internal
                julia-codegen
#https://cmake.org/cmake/help/latest/module/GNUInstallDirs.html 
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} 
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(FILES "etc/startup.jl" DESTINATION "${CMAKE_INSTALL_SYSCONFDIR}/julia")