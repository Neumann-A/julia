cmake_minimum_required(VERSION 3.21)

file(STRINGS "${INPUT}" contents REGEX "#define PCRE2_([^ \t]+)[ \t]+\\\(?(0x[0-9a-fA-F]+|[0-9]+|\\\([-0-9]+\\\))\\\)?u?")
list(TRANSFORM contents REPLACE "#define PCRE2_ERROR_([^ \t]+)[ \t]+\\\(?(0x[0-9a-fA-F]+|[0-9]+|\\\([-0-9]+\\\))\\\)?u?" "const ERROR_\\1 = Cint(\\2)")
list(TRANSFORM contents REPLACE "#define PCRE2_([^ \t]+)[ \t]+\\\(?(0x[0-9a-fA-F]+|[0-9]+|\\\([-0-9]+\\\))\\\)?u?" "const \\1 = UInt32(\\2)")
list(FILTER contents EXCLUDE REGEX "LOCAL_WIDTH = UInt32\\\((16|32)\\\)")
list(SORT contents)
list(JOIN contents "\n" contents_new)
file(WRITE "${OUTPUT}" "${contents_new}\n")
