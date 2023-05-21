# Selecting a default CMAKE_TOOLCHAIN_FILE if non was specified
include_guard(GLOBAL)
if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
    if(WIN32)
        set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/toolchains/x64_86-windows.cmake")
    endif()
endif()