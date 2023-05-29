const ALLOW_EMPTY_CLASS = UInt32(0x00000001)
const ALT_BSUX = UInt32(0x00000002)
const ALT_CIRCUMFLEX = UInt32(0x00200000)
const ALT_VERBNAMES = UInt32(0x00400000)
const ANCHORED = UInt32(0x80000000)
const AUTO_CALLOUT = UInt32(0x00000004)
const BSR_ANYCRLF = UInt32(2)
const BSR_UNICODE = UInt32(1)
const CALLOUT_BACKTRACK = UInt32(0x00000002)
const CALLOUT_STARTMATCH = UInt32(0x00000001)
const CASELESS = UInt32(0x00000008)
const CODE_UNIT_WIDTH = UInt32(8)
const CONFIG_BSR = UInt32(0)
const CONFIG_COMPILED_WIDTHS = UInt32(14)
const CONFIG_DEPTHLIMIT = UInt32(7)
const CONFIG_HEAPLIMIT = UInt32(12)
const CONFIG_JIT = UInt32(1)
const CONFIG_JITTARGET = UInt32(2)
const CONFIG_LINKSIZE = UInt32(3)
const CONFIG_MATCHLIMIT = UInt32(4)
const CONFIG_NEVER_BACKSLASH_C = UInt32(13)
const CONFIG_NEWLINE = UInt32(5)
const CONFIG_PARENSLIMIT = UInt32(6)
const CONFIG_RECURSIONLIMIT = UInt32(7)
const CONFIG_STACKRECURSE = UInt32(8)
const CONFIG_TABLES_LENGTH = UInt32(15)
const CONFIG_UNICODE = UInt32(9)
const CONFIG_UNICODE_VERSION = UInt32(10)
const CONFIG_VERSION = UInt32(11)
const CONVERT_GLOB = UInt32(0x00000010)
const CONVERT_GLOB_NO_STARSTAR = UInt32(0x00000050)
const CONVERT_GLOB_NO_WILD_SEPARATOR = UInt32(0x00000030)
const CONVERT_NO_UTF_CHECK = UInt32(0x00000002)
const CONVERT_POSIX_BASIC = UInt32(0x00000004)
const CONVERT_POSIX_EXTENDED = UInt32(0x00000008)
const CONVERT_UTF = UInt32(0x00000001)
const COPY_MATCHED_SUBJECT = UInt32(0x00004000)
const DFA_RESTART = UInt32(0x00000040)
const DFA_SHORTEST = UInt32(0x00000080)
const DOLLAR_ENDONLY = UInt32(0x00000010)
const DOTALL = UInt32(0x00000020)
const DUPNAMES = UInt32(0x00000040)
const ENDANCHORED = UInt32(0x20000000)
const ERROR_ALPHA_ASSERTION_UNKNOWN = Cint(195)
const ERROR_BACKSLASH_C_CALLER_DISABLED = Cint(183)
const ERROR_BACKSLASH_C_LIBRARY_DISABLED = Cint(185)
const ERROR_BACKSLASH_C_SYNTAX = Cint(168)
const ERROR_BACKSLASH_G_SYNTAX = Cint(157)
const ERROR_BACKSLASH_K_IN_LOOKAROUND = Cint(199)
const ERROR_BACKSLASH_K_SYNTAX = Cint(169)
const ERROR_BACKSLASH_N_IN_CLASS = Cint(171)
const ERROR_BACKSLASH_O_MISSING_BRACE = Cint(155)
const ERROR_BACKSLASH_U_CODE_POINT_TOO_BIG = Cint(177)
const ERROR_BADDATA = Cint((-29))
const ERROR_BADMAGIC = Cint((-31))
const ERROR_BADMODE = Cint((-32))
const ERROR_BADOFFSET = Cint((-33))
const ERROR_BADOFFSETLIMIT = Cint((-56))
const ERROR_BADOPTION = Cint((-34))
const ERROR_BADREPESCAPE = Cint((-57))
const ERROR_BADREPLACEMENT = Cint((-35))
const ERROR_BADSERIALIZEDDATA = Cint((-62))
const ERROR_BADSUBSPATTERN = Cint((-60))
const ERROR_BADSUBSTITUTION = Cint((-59))
const ERROR_BADUTFOFFSET = Cint((-36))
const ERROR_BAD_LITERAL_OPTIONS = Cint(192)
const ERROR_BAD_OPTIONS = Cint(117)
const ERROR_BAD_RELATIVE_REFERENCE = Cint(129)
const ERROR_BAD_SUBPATTERN_REFERENCE = Cint(115)
const ERROR_CALLOUT = Cint((-37))
const ERROR_CALLOUT_BAD_STRING_DELIMITER = Cint(182)
const ERROR_CALLOUT_NO_STRING_DELIMITER = Cint(181)
const ERROR_CALLOUT_NUMBER_TOO_BIG = Cint(138)
const ERROR_CALLOUT_STRING_TOO_LONG = Cint(172)
const ERROR_CLASS_INVALID_RANGE = Cint(150)
const ERROR_CLASS_RANGE_ORDER = Cint(108)
const ERROR_CODE_POINT_TOO_BIG = Cint(134)
const ERROR_CONDITION_ASSERTION_EXPECTED = Cint(128)
const ERROR_CONDITION_ATOMIC_ASSERTION_EXPECTED = Cint(198)
const ERROR_CONVERT_SYNTAX = Cint((-64))
const ERROR_DEFINE_TOO_MANY_BRANCHES = Cint(154)
const ERROR_DEPTHLIMIT = Cint((-53))
const ERROR_DFA_BADRESTART = Cint((-38))
const ERROR_DFA_RECURSE = Cint((-39))
const ERROR_DFA_UCOND = Cint((-40))
const ERROR_DFA_UFUNC = Cint((-41))
const ERROR_DFA_UINVALID_UTF = Cint((-66))
const ERROR_DFA_UITEM = Cint((-42))
const ERROR_DFA_WSSIZE = Cint((-43))
const ERROR_DUPLICATE_SUBPATTERN_NAME = Cint(143)
const ERROR_END_BACKSLASH = Cint(101)
const ERROR_END_BACKSLASH_C = Cint(102)
const ERROR_ESCAPE_INVALID_IN_CLASS = Cint(107)
const ERROR_ESCAPE_INVALID_IN_VERB = Cint(140)
const ERROR_HEAPLIMIT = Cint((-63))
const ERROR_HEAP_FAILED = Cint(121)
const ERROR_INTERNAL = Cint((-44))
const ERROR_INTERNAL_BAD_CODE = Cint(189)
const ERROR_INTERNAL_BAD_CODE_AUTO_POSSESS = Cint(180)
const ERROR_INTERNAL_BAD_CODE_IN_SKIP = Cint(190)
const ERROR_INTERNAL_BAD_CODE_LOOKBEHINDS = Cint(170)
const ERROR_INTERNAL_CODE_OVERFLOW = Cint(123)
const ERROR_INTERNAL_DUPMATCH = Cint((-65))
const ERROR_INTERNAL_MISSING_SUBPATTERN = Cint(153)
const ERROR_INTERNAL_OVERRAN_WORKSPACE = Cint(152)
const ERROR_INTERNAL_PARSED_OVERFLOW = Cint(163)
const ERROR_INTERNAL_STUDY_ERROR = Cint(131)
const ERROR_INTERNAL_UNEXPECTED_REPEAT = Cint(110)
const ERROR_INTERNAL_UNKNOWN_NEWLINE = Cint(156)
const ERROR_INVALID_AFTER_PARENS_QUERY = Cint(111)
const ERROR_INVALID_HEXADECIMAL = Cint(167)
const ERROR_INVALID_HYPHEN_IN_OPTIONS = Cint(194)
const ERROR_INVALID_OCTAL = Cint(164)
const ERROR_INVALID_SUBPATTERN_NAME = Cint(144)
const ERROR_JIT_BADOPTION = Cint((-45))
const ERROR_JIT_STACKLIMIT = Cint((-46))
const ERROR_LOOKBEHIND_INVALID_BACKSLASH_C = Cint(136)
const ERROR_LOOKBEHIND_NOT_FIXED_LENGTH = Cint(125)
const ERROR_LOOKBEHIND_TOO_COMPLICATED = Cint(135)
const ERROR_LOOKBEHIND_TOO_LONG = Cint(187)
const ERROR_MALFORMED_UNICODE_PROPERTY = Cint(146)
const ERROR_MARK_MISSING_ARGUMENT = Cint(166)
const ERROR_MATCHLIMIT = Cint((-47))
const ERROR_MISSING_CALLOUT_CLOSING = Cint(139)
const ERROR_MISSING_CLOSING_PARENTHESIS = Cint(114)
const ERROR_MISSING_COMMENT_CLOSING = Cint(118)
const ERROR_MISSING_CONDITION_CLOSING = Cint(124)
const ERROR_MISSING_NAME_TERMINATOR = Cint(142)
const ERROR_MISSING_OCTAL_OR_HEX_DIGITS = Cint(178)
const ERROR_MISSING_SQUARE_BRACKET = Cint(106)
const ERROR_MIXEDTABLES = Cint((-30))
const ERROR_NOMATCH = Cint((-1))
const ERROR_NOMEMORY = Cint((-48))
const ERROR_NOSUBSTRING = Cint((-49))
const ERROR_NOUNIQUESUBSTRING = Cint((-50))
const ERROR_NO_SURROGATES_IN_UTF16 = Cint(191)
const ERROR_NULL = Cint((-51))
const ERROR_NULL_PATTERN = Cint(116)
const ERROR_OCTAL_BYTE_TOO_BIG = Cint(151)
const ERROR_PARENS_QUERY_R_MISSING_CLOSING = Cint(158)
const ERROR_PARENTHESES_NEST_TOO_DEEP = Cint(119)
const ERROR_PARENTHESES_STACK_CHECK = Cint(133)
const ERROR_PARTIAL = Cint((-2))
const ERROR_PATTERN_STRING_TOO_LONG = Cint(188)
const ERROR_PATTERN_TOO_COMPLICATED = Cint(186)
const ERROR_PATTERN_TOO_LARGE = Cint(120)
const ERROR_POSIX_CLASS_NOT_IN_CLASS = Cint(112)
const ERROR_POSIX_NO_SUPPORT_COLLATING = Cint(113)
const ERROR_QUANTIFIER_INVALID = Cint(109)
const ERROR_QUANTIFIER_OUT_OF_ORDER = Cint(104)
const ERROR_QUANTIFIER_TOO_BIG = Cint(105)
const ERROR_QUERY_BARJX_NEST_TOO_DEEP = Cint(184)
const ERROR_RECURSELOOP = Cint((-52))
const ERROR_RECURSIONLIMIT = Cint((-53))
const ERROR_REPMISSINGBRACE = Cint((-58))
const ERROR_SCRIPT_RUN_NOT_AVAILABLE = Cint(196)
const ERROR_SUBPATTERN_NAMES_MISMATCH = Cint(165)
const ERROR_SUBPATTERN_NAME_EXPECTED = Cint(162)
const ERROR_SUBPATTERN_NAME_TOO_LONG = Cint(148)
const ERROR_SUBPATTERN_NUMBER_TOO_BIG = Cint(161)
const ERROR_SUPPORTED_ONLY_IN_UNICODE = Cint(193)
const ERROR_TOOMANYREPLACE = Cint((-61))
const ERROR_TOO_MANY_CAPTURES = Cint(197)
const ERROR_TOO_MANY_CONDITION_BRANCHES = Cint(127)
const ERROR_TOO_MANY_NAMED_SUBPATTERNS = Cint(149)
const ERROR_UCP_IS_DISABLED = Cint(175)
const ERROR_UNAVAILABLE = Cint((-54))
const ERROR_UNICODE_DISALLOWED_CODE_POINT = Cint(173)
const ERROR_UNICODE_NOT_SUPPORTED = Cint(132)
const ERROR_UNICODE_PROPERTIES_UNAVAILABLE = Cint(145)
const ERROR_UNKNOWN_ESCAPE = Cint(103)
const ERROR_UNKNOWN_POSIX_CLASS = Cint(130)
const ERROR_UNKNOWN_UNICODE_PROPERTY = Cint(147)
const ERROR_UNMATCHED_CLOSING_PARENTHESIS = Cint(122)
const ERROR_UNRECOGNIZED_AFTER_QUERY_P = Cint(141)
const ERROR_UNSET = Cint((-55))
const ERROR_UNSUPPORTED_ESCAPE_SEQUENCE = Cint(137)
const ERROR_UTF16_ERR1 = Cint((-24))
const ERROR_UTF16_ERR2 = Cint((-25))
const ERROR_UTF16_ERR3 = Cint((-26))
const ERROR_UTF32_ERR1 = Cint((-27))
const ERROR_UTF32_ERR2 = Cint((-28))
const ERROR_UTF8_ERR1 = Cint((-3))
const ERROR_UTF8_ERR10 = Cint((-12))
const ERROR_UTF8_ERR11 = Cint((-13))
const ERROR_UTF8_ERR12 = Cint((-14))
const ERROR_UTF8_ERR13 = Cint((-15))
const ERROR_UTF8_ERR14 = Cint((-16))
const ERROR_UTF8_ERR15 = Cint((-17))
const ERROR_UTF8_ERR16 = Cint((-18))
const ERROR_UTF8_ERR17 = Cint((-19))
const ERROR_UTF8_ERR18 = Cint((-20))
const ERROR_UTF8_ERR19 = Cint((-21))
const ERROR_UTF8_ERR2 = Cint((-4))
const ERROR_UTF8_ERR20 = Cint((-22))
const ERROR_UTF8_ERR21 = Cint((-23))
const ERROR_UTF8_ERR3 = Cint((-5))
const ERROR_UTF8_ERR4 = Cint((-6))
const ERROR_UTF8_ERR5 = Cint((-7))
const ERROR_UTF8_ERR6 = Cint((-8))
const ERROR_UTF8_ERR7 = Cint((-9))
const ERROR_UTF8_ERR8 = Cint((-10))
const ERROR_UTF8_ERR9 = Cint((-11))
const ERROR_UTF_IS_DISABLED = Cint(174)
const ERROR_VERB_ARGUMENT_NOT_ALLOWED = Cint(159)
const ERROR_VERB_NAME_TOO_LONG = Cint(176)
const ERROR_VERB_UNKNOWN = Cint(160)
const ERROR_VERSION_CONDITION_SYNTAX = Cint(179)
const ERROR_ZERO_RELATIVE_REFERENCE = Cint(126)
const EXTENDED = UInt32(0x00000080)
const EXTENDED_MORE = UInt32(0x01000000)
const EXTRA_ALLOW_LOOKAROUND_BSK = UInt32(0x00000040)
const EXTRA_ALLOW_SURROGATE_ESCAPES = UInt32(0x00000001)
const EXTRA_ALT_BSUX = UInt32(0x00000020)
const EXTRA_BAD_ESCAPE_IS_LITERAL = UInt32(0x00000002)
const EXTRA_ESCAPED_CR_IS_LF = UInt32(0x00000010)
const EXTRA_MATCH_LINE = UInt32(0x00000008)
const EXTRA_MATCH_WORD = UInt32(0x00000004)
const FIRSTLINE = UInt32(0x00000100)
const INFO_ALLOPTIONS = UInt32(0)
const INFO_ARGOPTIONS = UInt32(1)
const INFO_BACKREFMAX = UInt32(2)
const INFO_BSR = UInt32(3)
const INFO_CAPTURECOUNT = UInt32(4)
const INFO_DEPTHLIMIT = UInt32(21)
const INFO_EXTRAOPTIONS = UInt32(26)
const INFO_FIRSTBITMAP = UInt32(7)
const INFO_FIRSTCODETYPE = UInt32(6)
const INFO_FIRSTCODEUNIT = UInt32(5)
const INFO_FRAMESIZE = UInt32(24)
const INFO_HASBACKSLASHC = UInt32(23)
const INFO_HASCRORLF = UInt32(8)
const INFO_HEAPLIMIT = UInt32(25)
const INFO_JCHANGED = UInt32(9)
const INFO_JITSIZE = UInt32(10)
const INFO_LASTCODETYPE = UInt32(12)
const INFO_LASTCODEUNIT = UInt32(11)
const INFO_MATCHEMPTY = UInt32(13)
const INFO_MATCHLIMIT = UInt32(14)
const INFO_MAXLOOKBEHIND = UInt32(15)
const INFO_MINLENGTH = UInt32(16)
const INFO_NAMECOUNT = UInt32(17)
const INFO_NAMEENTRYSIZE = UInt32(18)
const INFO_NAMETABLE = UInt32(19)
const INFO_NEWLINE = UInt32(20)
const INFO_RECURSIONLIMIT = UInt32(21)
const INFO_SIZE = UInt32(22)
const JIT_COMPLETE = UInt32(0x00000001)
const JIT_INVALID_UTF = UInt32(0x00000100)
const JIT_PARTIAL_HARD = UInt32(0x00000004)
const JIT_PARTIAL_SOFT = UInt32(0x00000002)
const LITERAL = UInt32(0x02000000)
const LOCAL_WIDTH = UInt32(16)
const LOCAL_WIDTH = UInt32(32)
const LOCAL_WIDTH = UInt32(8)
const MAJOR = UInt32(10)
const MATCH_INVALID_UTF = UInt32(0x04000000)
const MATCH_UNSET_BACKREF = UInt32(0x00000200)
const MINOR = UInt32(40)
const MULTILINE = UInt32(0x00000400)
const NEVER_BACKSLASH_C = UInt32(0x00100000)
const NEVER_UCP = UInt32(0x00000800)
const NEVER_UTF = UInt32(0x00001000)
const NEWLINE_ANY = UInt32(4)
const NEWLINE_ANYCRLF = UInt32(5)
const NEWLINE_CR = UInt32(1)
const NEWLINE_CRLF = UInt32(3)
const NEWLINE_LF = UInt32(2)
const NEWLINE_NUL = UInt32(6)
const NOTBOL = UInt32(0x00000001)
const NOTEMPTY = UInt32(0x00000004)
const NOTEMPTY_ATSTART = UInt32(0x00000008)
const NOTEOL = UInt32(0x00000002)
const NO_AUTO_CAPTURE = UInt32(0x00002000)
const NO_AUTO_POSSESS = UInt32(0x00004000)
const NO_DOTSTAR_ANCHOR = UInt32(0x00008000)
const NO_JIT = UInt32(0x00002000)
const NO_START_OPTIMIZE = UInt32(0x00010000)
const NO_UTF_CHECK = UInt32(0x40000000)
const PARTIAL_HARD = UInt32(0x00000020)
const PARTIAL_SOFT = UInt32(0x00000010)
const SUBSTITUTE_EXTENDED = UInt32(0x00000200)
const SUBSTITUTE_GLOBAL = UInt32(0x00000100)
const SUBSTITUTE_LITERAL = UInt32(0x00008000)
const SUBSTITUTE_MATCHED = UInt32(0x00010000)
const SUBSTITUTE_OVERFLOW_LENGTH = UInt32(0x00001000)
const SUBSTITUTE_REPLACEMENT_ONLY = UInt32(0x00020000)
const SUBSTITUTE_UNKNOWN_UNSET = UInt32(0x00000800)
const SUBSTITUTE_UNSET_EMPTY = UInt32(0x00000400)
const UCP = UInt32(0x00020000)
const UNGREEDY = UInt32(0x00040000)
const USE_OFFSET_LIMIT = UInt32(0x00800000)
const UTF = UInt32(0x00080000)
