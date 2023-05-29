cmake_minimum_required(VERSION 3.21)

if(NOT INPUT)
    message(FATAL_ERROR "Require input")
endif()

if(NOT LINES)
    message(FATAL_ERROR "Require number of LINES")
endif()

if(NOT OUTPUT)
    set(OUTPUT "${INPUT}")
endif()

file(STRINGS "${INPUT}" contents)

list(LENGTH contents length)
math(EXPR start "${length}-${LINES}" OUTPUT_FORMAT DECIMAL)
list(SUBLIST contents "${start}" "${LINES}" contents_tail)
list(JOIN contents_tail "\n" contents_tail)

file(WRITE "${OUTPUT}" "${contents_tail}")