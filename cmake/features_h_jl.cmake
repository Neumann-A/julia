cmake_minimum_required(VERSION 3.21)

set(JL_ARCHS X86 AArch32 AArch64)
set(final_contents "# This file is autogenerated by CMake")
foreach(arch IN LISTS JL_ARCHS)
    string(TOLOWER "${arch}" archl)
    set(feat_file "${CMAKE_CURRENT_SOURCE_DIR}/../src/features_${archl}.h")
    set(contents "")
    file(STRINGS "${INPUT}" contents REGEX "^JL_FEATURE_DEF") # also filters commented sections
    list(TRANSFORM contents 
         REPLACE 
            "^JL_FEATURE_DEF(_NAME)?\\\(([^,]+),[ \t]*([^,]),[^)]+\\\)" 
            "const JL_{arch}_\\1 = UInt32(\\2)"
        )
    list(JOIN contents "\n" contents_new)
    string(APPEND final_contents "# ${arch} features\n" "${contents_new}\n" )
endforeach()
file(WRITE "${CMAKE_CURRENT_BINARY_DIR}/features_h.jl" "${final_contents}\n")




# define parse_features
# @echo "# $(2) features" >> $@
# @$(call PRINT_PERL, cat $(SRCDIR)/../src/features_$(1).h | perl -lne 'print "const JL_$(2)_$$1 = UInt32($$2)" if /^\s*JL_FEATURE_DEF(?:_NAME)?\(\s*(\w+)\s*,\s*([^,]+)\s*,.*\)\s*(?:\/\/.*)?$$/' >> $@)
# @echo >> $@
# endef

# $(BUILDDIR)/features_h.jl: $(SRCDIR)/../src/features_x86.h $(SRCDIR)/../src/features_aarch32.h $(SRCDIR)/../src/features_aarch64.h
# 	@-rm -f $@
# 	@$(call parse_features,x86,X86)
# 	@$(call parse_features,aarch32,AArch32)
# 	@$(call parse_features,aarch64,AArch64)

# const JL_X86_rdrnd = UInt32(30)
# const JL_X86_avx2 = UInt32(32 * 2 + 5)
# const JL_AArch32_v8_6a = UInt32(32 * 2 + 11)

# # AArch64 features
# const JL_AArch64_aes = UInt32(4)