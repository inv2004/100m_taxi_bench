{.passC: "-mavx2".}
{.passL: "-mavx2".}

type m256i* {.importc: "__m256i", header: "immintrin.h".} = object
type mmask32* {.importc: "__mmask32", header: "immintrin.h".} = object

const avx2width* = 32

proc mm256_set1_epi8*(b: int8 | uint8): m256i
  {.importc: "_mm256_set1_epi8", header: "immintrin.h".}

proc mm256_loadu_byte*(p: ptr m256i): m256i
  {.importc: "_mm256_loadu_si256", header: "immintrin.h".}

proc popcnt_u32*(a: int32): int32
  {.importc: "_mm_popcnt_u32", header: "immintrin.h".}

proc mm256_cmpeq_epi8*(a, b: m256i): m256i
  {.importc: "_mm256_cmpeq_epi8", header: "immintrin.h".}

proc mm256_cmpeq_epi8_mask*(a, b: m256i): mmask32
  {.importc: "_mm256_cmpeq_epi8_mask", header: "immintrin.h".}

proc mm256_cmpgt_epi8*(a, b: m256i): m256i
  {.importc: "_mm256_cmpgt_epi8", header: "immintrin.h".}

proc cvtmask32_u32*(a: mmask32): int32
  {.importc: "_cvtmask64_u64", header: "immintrin.h".}

proc mm256_movemask_epi8*(a: m256i): int32
  {.importc: "_mm256_movemask_epi8", header: "immintrin.h".}

proc mm256_extract_epi8*(a: m256i, off: int): byte
  {.importc: "_mm256_extract_epi8", header: "immintrin.h".}


