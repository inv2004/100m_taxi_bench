import taxi/avx2
import taxi/avx512
import unrolled

import bitops
import macros

type Avg = tuple
  sum: float64
  cnt: int64

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
      unroll for off in 0..<(avx512width div 4):
        let low32 = mm512_cvtsi512_si32 mm512_alignr_epi32(ymm, ymm, off)
        result[0xFF and low32].inc
        result[0xFF and (low32 shr 8)].inc
        result[0xFF and (low32 shr 16)].inc
        result[0xFF and (low32 shr 24)].inc
    i += avx512width
  while i < a.len:
    result[a[i]].inc
    inc i

proc countGroupByAVX512Limited*(a: openArray[uint8]): array[256, int64] =
  let mask0 = mm512_set1_epi8(0)
  let mask1 = mm512_set1_epi8(1)
  let mask2 = mm512_set1_epi8(2)
  let mask3 = mm512_set1_epi8(3)
  var i = 0
  while i <= a.len-avx512width:
    let ymm = mm512_loadu_byte(cast[ptr m512i](unsafeAddr a[i]))
    result[0] += popcnt_u64 cvtmask64_u64 mm512_cmpeq_epi8_mask(ymm, mask0)
    result[1] += popcnt_u64 cvtmask64_u64 mm512_cmpeq_epi8_mask(ymm, mask1)
    result[2] += popcnt_u64 cvtmask64_u64 mm512_cmpeq_epi8_mask(ymm, mask2)
    result[3] += popcnt_u64 cvtmask64_u64 mm512_cmpeq_epi8_mask(ymm, mask3)
    i += avx512width
  while i < a.len:
    result[a[i]].inc
    inc i

proc avgGroupBy*(a: var openArray[byte], b: openArray[float64]): array[256, Avg] =
  for i, idx in a:
    result[idx].sum += b[i]
    inc result[idx].cnt

macro avx512proc(i: int) =
  let m = ident("m" & $intVal(i))
  let mask = ident("mask" & $intVal(i))
  result = quote do:
    let `m` = mm512_cmpeq_epi64_mask(ymm, `mask`)
    result[`i`].sum += mm512_reduce_add_pd mm512_maskz_mov_pd(`m`, fmm)
    result[`i`].cnt += popcount(cast[byte](`m`))

proc avgGroupByAVX512Limited*(a: openArray[byte], b: openArray[float64]): array[256, Avg] =
  let mask0 = mm512_set1_epi64(0)
  let mask1 = mm512_set1_epi64(1)
  let mask2 = mm512_set1_epi64(2)
  let mask3 = mm512_set1_epi64(3)
  let mask4 = mm512_set1_epi64(4)
  let mask5 = mm512_set1_epi64(5)
  let mask6 = mm512_set1_epi64(6)
  let mask7 = mm512_set1_epi64(7)
  var i = 0
  while i <= a.len-8:
    # let ymm = mm512_loadu_byte(cast[ptr m512i](unsafeAddr a[i]))
    let ymm = mm512_set_epi64(int(a[i+7]), int(a[i+6]), int(a[i+5]), int(a[i+4]), int(a[i+3]), int(a[i+2]), int(a[i+1]), int(a[i+0]))
    let fmm = mm512_loadu_float(unsafeAddr b[i])

    avx512proc(0)
    avx512proc(1)
    avx512proc(2)
    avx512proc(3)
    avx512proc(4)
    avx512proc(5)
    avx512proc(6)
    avx512proc(7)

    i += 8
  while i < a.len:
    let idx = a[i]
    result[idx].sum += b[i]
    inc result[idx].cnt
    inc i

when isMainModule:
  const N = 8
  proc main() =
    var VEC1 = newSeq[byte](N)
    var VECF = newSeq[float64](N)
    for i in 0..<N:
      VEC1[i] = byte(i mod 5)
      VECF[i] = float64(i mod 50)
    echo VEC1
    echo VECF

    echo avgGroupByAVX512Limited(VEC1, VECF)

  main()
