# File for platform and compiler dependent setup
include_guard(GLOBAL)

if(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
    message(FATAL_ERROR "Julia cannot be build with Microsoft Visual Studio due to the usage of inline assembly. Consider using clang-cl via LLVM")
endif()

if(CMAKE_SYSTEM_PROCESSOR MATCHES "^(AMD64|x86_64)$")
    set(JL_ARCH "x86_64")
endif()