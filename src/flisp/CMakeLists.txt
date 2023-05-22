
#REQUIRES LIBUTF8PROC
#JL_LIBRARY_EXPORTS_INTERNAL
#flisp.boot
# CMAKE_CROSSCOMPILING?
set(flisp_SRCS 
        flisp.c builtins.c string.c equalhash.c table.c iostream.c 
        julia_extensions.c
)

add_library(flisp STATIC ${flisp_SRCS})
add_library(jl::flisp ALIAS flisp)
target_link_libraries(flisp PUBLIC jl::support jl::libuv)
target_compile_definitions(flisp PRIVATE "JL_LIBRARY_EXPORTS_INTERNAL")

if(CMAKE_CROSSCOMPILING)
    find_program(FLISP_EXECUTABLE NAMES flisp PATHS bin REQUIRED)
else()
    add_executable(flisp_bin flmain.c flisp.h)
    add_executable(jl::bin::flisp ALIAS flisp_bin)
    set_target_properties(flisp_bin PROPERTIES OUTPUT_NAME flisp ARCHIVE_OUTPUT_NAME flisp_exe LIBRARY_OUTPUT_NAME flisp_exe)
    target_link_libraries(flisp_bin PRIVATE jl::flisp)
    set(FLISP_EXECUTABLE flisp_bin)
endif()

set(flisp_julia_boot_sources 
    mk_julia_flisp_boot.scm
    jlfrontend.scm 
)

list(TRANSFORM flisp_julia_boot_sources PREPEND "${CMAKE_CURRENT_SOURCE_DIR}/../")

file(COPY "flisp.boot" DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")

add_custom_target(gen_julia_flisp_boot
                  COMMAND 
                    ${FLISP_EXECUTABLE} 
                    mk_julia_flisp_boot.scm
                    "${CMAKE_CURRENT_SOURCE_DIR}/../"
                    jlfrontend.scm
                    #${flisp_boot_sources}
                    "${CMAKE_CURRENT_BINARY_DIR}/../julia_flisp.boot"
                  BYPRODUCTS "${CMAKE_CURRENT_BINARY_DIR}/../julia_flisp.boot"
                  SOURCES 
                    ${flisp_julia_boot_sources}
                  WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/.."
)

add_custom_target(gen_julia_flisp_boot_inc 
                  COMMAND 
                    ${FLISP_EXECUTABLE} 
                    "bin2hex.scm" 
                    < "${CMAKE_CURRENT_BINARY_DIR}/../julia_flisp.boot"
                    > "${CMAKE_CURRENT_BINARY_DIR}/../julia_flisp.boot.inc"
                  DEPENDS gen_julia_flisp_boot
                  BYPRODUCTS "${CMAKE_CURRENT_BINARY_DIR}/../julia_flisp.boot.inc"
                  SOURCES 
                    "${CMAKE_CURRENT_SOURCE_DIR}/../bin2hex.scm" 
                  WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/.."
)

