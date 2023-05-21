
#REQUIRES LIBUTF8PROC
#JL_LIBRARY_EXPORTS_INTERNAL
#flisp.boot
# CMAKE_CROSSCOMPILING?
set(flisp_SRCS 
        flisp.c builtins.c string.c 
        equalhash.c table.c iostream.c 
        julia_extensions.c cvalues.c types.c 
        flisp.h print.c read.c equal.c
    )

add_library(flisp STATIC ${flisp_SRCS})
add_library(jl::flisp ALIAS flisp)

add_executable(flisp_bin flmain.c flisp.h)
add_library(jl::bin::flisp ALIAS flisp_bin)
set_target_properties(flisp_bin PROPERTIEIS OUTPUT_NAME flisp)
target_link_libraries(flisp_bin PRIVATE jl::flisp jl::support)