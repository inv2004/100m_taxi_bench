{.passC: "-mavx512f -mavx512bw".}
{.passL: "-mavx512f -mavx512bw".}

import avx2

import strutils

type m512i* {.importc: "__m512i", header: "immintrin.h".} = object
type m512d* {.importc: "__m512d", header: "immintrin.h".} = object
type mmask64* {.importc: "__mmask64", header: "immintrin.h".} = object
type mmask8* {.importc: "__mmask8", header: "immintrin.h".} = object

const avx512width* = 64

proc `$`*(m: mmask8): string =
  toBin int(cast[uint8](m)), 8*sizeof(uint8)

proc mm512_set1_epi8*(b: int8 | uint8): m512i
  {.importc: "_mm512_set1_epi8", header: "immintrin.h".}

proc mm512_set1_epi64*(a: int64): m512i
  {.importc: "_mm512_set1_epi64", header: "immintrin.h".}

proc mm512_loadu_byte*(p: ptr m512i): m512i
  {.importc: "_mm512_loadu_si512", header: "immintrin.h".}

proc mm512_cmpeq_epi8_mask*(a, b: m512i): mmask64
  {.importc: "_mm512_cmpeq_epi8_mask", header: "immintrin.h".}

proc mm512_cmpgt_epi8_mask*(a, b: m512i): mmask64
  {.importc: "_mm512_cmpgt_epi8_mask", header: "immintrin.h".}

proc cvtmask64_u64*(a: mmask64): int64
  {.importc: "_cvtmask64_u64", header: "immintrin.h".}

proc popcnt_u64*(a: int64): int64
  {.importc: "_mm_popcnt_u64", header: "immintrin.h".}

proc mm512_movemask_epi8*(a: m512i): int32
  {.importc: "_mm512_movemask_epi8", header: "immintrin.h".}

proc mm512_extract_epi8*(a: m512i, off: int): byte
  {.importc: "_mm512_extract_epi8", header: "immintrin.h".}

proc mm512_extracti64x4_epi64*(a: m512i, off: int): m256i
  {.importc: "_mm512_extracti64x4_epi64", header: "immintrin.h".}

proc mm512_shuffle_epi32*(a: m512i, off: int): m512i
  {.importc: "_mm512_shuffle_epi32", header: "immintrin.h".}

proc mm512_cvtsi512_si32*(a: m512i): int64
  {.importc: "_mm512_cvtsi512_si32 ", header: "immintrin.h".}

proc mm512_alignr_epi32*(a, b: m512i, off: int): m512i
  {.importc: "_mm512_alignr_epi32 ", header: "immintrin.h".}

proc mm512_cmpeq_epi64_mask*(a, b: m512i): mmask8
  {.importc: "_mm512_cmpeq_epi64_mask ", header: "immintrin.h".}

proc mm512_loadu_float*(p: ptr float64): m512d
  {.importc: "_mm512_loadu_pd", header: "immintrin.h".}

proc mm512_maskz_mov_pd*(m: mmask8, a: m512d): m512d
  {.importc: "_mm512_maskz_mov_pd ", header: "immintrin.h".}

proc mm512_reduce_add_pd*(a: m512d): float64
  {.importc: "_mm512_reduce_add_pd ", header: "immintrin.h".}

proc mm512_set_epi64*(e0,e1,e2,e3,e4,e5,e6,e7: int64): m512i
  {.importc: "_mm512_set_epi64", header: "immintrin.h".}

proc mm512_set_epi8*(e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11,e12,e13,e14,e15,e16,e17,e18,e19,e20,e21,e22,e23,e24,e25,e26,e27,e28,e29,e30,e31,e32,e33,e34,e35,e36,e37,e38,e39,e40,e41,e42,e43,e44,e45,e46,e47,e48,e49,e50,e51,e52,e53,e54,e55,e56,e57,e58,e59,e60,e61,e62,e63: byte): m512i
  {.importc: "_mm512_set_epi8", header: "immintrin.h".}


