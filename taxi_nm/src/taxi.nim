import taxi/avx2
import unrolled

proc sum*(a: openArray[int]): int =
  for x in a:
    result += int(x)

func countGroupBy*(a: openArray[uint8]): array[256, int] =
  for x in a:
    inc result[x]

proc countGroupByAVX2*(a: openArray[uint8]): array[256, int] =
  let mask0 = set1_epi8(0)
  let mask1 = set1_epi8(1)
  let mask2 = set1_epi8(2)
  let mask3 = set1_epi8(3)
  var i = 0
  while i < a.len-avx2width:
    let ymm = loadu_byte(cast[ptr m256i](unsafeAddr a[i]))
    if 0 < popcnt_u32 movemask_epi8 cmpgt_epi8(ymm, mask3):
      unroll for off in 0..<avx2width:
        result[extract_epi8(ymm, off)].inc
    else:
      result[0] += popcnt_u32 movemask_epi8 cmpeq_epi8(ymm, mask0)
      result[1] += popcnt_u32 movemask_epi8 cmpeq_epi8(ymm, mask1)
      result[2] += popcnt_u32 movemask_epi8 cmpeq_epi8(ymm, mask2)
      result[3] += popcnt_u32 movemask_epi8 cmpeq_epi8(ymm, mask3)
    i += avx2width
  while i < a.len:
    result[a[i]].inc
    inc i

