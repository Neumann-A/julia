include_guard(GLOBAL)
function(run_c_preprocessor)
    cmake_parse_arguments(PARSE_ARGV  0 arg 
                            "" # Options
                            "SOURCE;OUTPUT;TARGET" # Single value args
                            "EXTRA_C_FLAGS" # Multi value args
                         )
    string(TOUPPER ${CMAKE_BUILD_TYPE} build_type)

    if(MSVC AND CMAKE_C_COMPILER_ID STREQUAL "Clang")
        string(APPEND arg_EXTRA_C_FLAGS " -d1PP")
    endif()

    add_custom_command(
        OUTPUT "${arg_OUTPUT}"
        COMMAND ${CMAKE_C_COMPILER}
            "-D$<JOIN:$<TARGET_PROPERTY:${arg_TARGET},COMPILE_DEFINITIONS>,;-D>"
            "-I$<JOIN:$<TARGET_PROPERTY:${arg_TARGET},INCLUDE_DIRECTORIES>,;-I>"
            ${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_${build_type}}
            $<TARGET_PROPERTY:${arg_TARGET},COMPILE_OPTIONS>
            ${arg_EXTRA_C_FLAGS}
            -E ${arg_SOURCE} -o ${arg_OUTPUT}
        COMMAND_EXPAND_LISTS VERBATIM
        IMPLICIT_DEPENDS C ${arg_SOURCE}
        DEPENDS ${arg_SOURCE}
        )
endfunction()