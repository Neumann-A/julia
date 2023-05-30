cmake_minimum_required(VERSION 3.21)

set(search_regex "#define[ \t]+(E[^ \t]+)[ \t]+([0-9]+)")

file(STRINGS "${INPUT}" contents REGEX "${search_regex}")
list(TRANSFORM contents REPLACE "${search_regex}" "const \\1 = Int32(\\2)")
list(SORT contents)

list(JOIN contents "\n" contents_new)
file(WRITE "${OUTPUT}" "${contents_new}\n")