cmake_minimum_required(VERSION 3.21)

file(STRINGS "${INPUT}" contents REGEX "const[ \t]+JL_O_[^ \t]+")

#$(BUILDDIR)/file_constants.jl: $(SRCDIR)/../src/file_constants.h
#	@$(call PRINT_PERL, $(CPP_STDOUT) -DJULIA $< | perl -nle 
#'print "$$1 0o$$2" if /^(\s*const\s+[A-z_]+\s+=)\s+(0[0-9]*)\s*$$/;
# print "$$1" if /^\s*(const\s+[A-z_]+\s+=\s+([1-9]|0x)[0-9A-z]*)\s*$$/' > $@)


list(JOIN contents "\n" contents_new)
file(WRITE "${OUTPUT}" "${contents_new}\n")