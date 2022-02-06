{.passC: "-mavx512f -mavx512bw".}
{.passL: "-mavx512f -mavx512bw".}

type m512i* {.importc: "__m512i", header: "immintrin.h".} = object
type mmask64* {.importc: "__mmask64", header: "immintrin.h".} = object

const avx512width* = 64

proc mm512_set1_epi8*(b: int8 | uint8): m512i
  {.importc: "_mm512_set1_epi8", header: "immintrin.h".}

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
