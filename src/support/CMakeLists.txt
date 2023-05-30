set(support_SRCS 
        hashing.c timefuncs.c ptrhash.c operators.c utf8.c ios.c htable.c bitvector.c
        int2str.c libsupportinit.c arraylist.c strtod.c rle.c
    )

if(WIN32)
    list(APPEND support_SRCS asprintf.c strptime.c)
    if(JL_ARCH STREQUAL "x86_64")
        enable_language(ASM)
        add_library(setjmp_impl OBJECT _setjmp.win64.S)
        list(APPEND support_SRCS "$<TARGET_OBJECTS:setjmp_impl>")
    endif()
endif()

add_library(support OBJECT ${support_SRCS})
add_library(jl::support ALIAS support)
target_compile_definitions(support PRIVATE "JL_LIBRARY_EXPORTS_INTERNAL")
target_include_directories(support PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>")
target_link_libraries(support PRIVATE jl::utf8proc)

# TODO: -I$(LIBUV_INC) -I$(UTF8PROC_INC)
