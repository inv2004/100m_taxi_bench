import taxi/avx2
import taxi/avx512
import unrolled

proc sum*(a: openArray[int64]): int64 =
  for x in a:
    result += int(x)

func countGroupBy*(a: openArray[uint8]): array[256, int64] =
  for x in a:
    inc result[x]

proc countGroupByAVX2*(a: openArray[uint8]): array[256, int64] =
  let mask0 = mm256_set1_epi8(0)
  let mask1 = mm256_set1_epi8(1)
  let mask2 = mm256_set1_epi8(2)
  let mask3 = mm256_set1_epi8(3)
  var i = 0
  while i <= a.len-avx2width:
    let ymm = mm256_loadu_byte(cast[ptr m256i](unsafeAddr a[i]))
    if 0 == mm256_movemask_epi8 mm256_cmpgt_epi8(ymm, mask3):
      result[0] += popcnt_u32 cvtmask32_u32 mm256_cmpeq_epi8_mask(ymm, mask0)
      result[1] += popcnt_u32 cvtmask32_u32 mm256_cmpeq_epi8_mask(ymm, mask1)
      result[2] += popcnt_u32 cvtmask32_u32 mm256_cmpeq_epi8_mask(ymm, mask2)
      result[3] += popcnt_u32 cvtmask32_u32 mm256_cmpeq_epi8_mask(ymm, mask3)
    else:
      unroll for off in 0..<avx2width:
        result[mm256_extract_epi8(ymm, off)].inc
    i += avx2width
  while i < a.len:
    result[a[i]].inc
    inc i

proc countGroupByAVX512*(a: openArray[uint8]): array[256, int64] =
  let mask0 = mm512_set1_epi8(0)
  let mask1 = mm512_set1_epi8(1)
  let mask2 = mm512_set1_epi8(2)
  let mask3 = mm512_set1_epi8(3)
  var i = 0
  while i <= a.len-avx512width:
    let ymm = mm512_loadu_byte(cast[ptr m512i](unsafeAddr a[i]))
    if 0 == cvtmask64_u64 mm512_cmpgt_epi8_mask(ymm, mask3):
      result[0] += popcnt_u64 cvtmask64_u64 mm512_cmpeq_epi8_mask(ymm, mask0)
      result[1] += popcnt_u64 cvtmask64_u64 mm512_cmpeq_epi8_mask(ymm, mask1)
      result[2] += popcnt_u64 cvtmask64_u64 mm512_cmpeq_epi8_mask(ymm, mask2)
      result[3] += popcnt_u64 cvtmask64_u64 mm512_cmpeq_epi8_mask(ymm, mask3)
    else:
      let ymmLow = mm512_extracti64x4_epi64(ymm, 0)
      let ymmHigh = mm512_extracti64x4_epi64(ymm, 1)
      unroll for off in 0..<avx2width:
        result[mm256_extract_epi8(ymmLow, off)].inc
      unroll for off in 0..<avx2width:
        result[mm256_extract_epi8(ymmHigh, off)].inc
    i += avx512width
  while i < a.len:
    result[a[i]].inc
    inc i


when isMainModule:
  const N = 64
  proc main() =
    var VEC1 = newSeq[uint8](N)
    var i = 0
    for x in VEC1.mitems:
      x = byte(i mod 5)
      inc i
    echo VEC1

    echo countGroupByAVX512(VEC1)

  main()
