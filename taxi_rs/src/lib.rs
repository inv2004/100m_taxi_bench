use core::arch::x86_64::{__m256i, _mm256_set1_epi8, _mm256_loadu_si256, _mm256_cmpgt_epi8, _mm256_cmpeq_epi8, _mm256_movemask_epi8, _popcnt32, _mm256_extract_epi8};
use std::ptr::{addr_of};

pub fn count_group_by(a: &[u8]) -> [i64; 256] {
    let mut result = [0; 256];
    for &x in a {
        result[x as usize] += 1;
    }
    result
}

pub fn sum(a: &[i64]) -> i64 {
    let mut result = 0;
    for x in a {
        result += x;
    }
    result
}

// proc countGroupByAVX2*(a: openArray[uint8]): array[256, int] =
//   let mask0 = set1_epi8(0)
//   let mask1 = set1_epi8(1)
//   let mask2 = set1_epi8(2)
//   let mask3 = set1_epi8(3)
//   var i = 0
//   while i < a.len-avx2width:
//     let ymm = loadu_byte(unsafeAddr a[i])
//     if 0 < popcnt_u32 movemask_epi8 cmpgt_epi8(ymm, mask3):
//       unroll for off in 0..<avx2width:
//         result[extract_epi8(ymm, off)].inc
//     else:
//       result[0] += popcnt_u32 movemask_epi8 cmpeq_epi8(ymm, mask0)
//       result[1] += popcnt_u32 movemask_epi8 cmpeq_epi8(ymm, mask1)
//       result[2] += popcnt_u32 movemask_epi8 cmpeq_epi8(ymm, mask2)
//       result[3] += popcnt_u32 movemask_epi8 cmpeq_epi8(ymm, mask3)
//     i += avx2width
//   for i in i..<a.len:
//     result[a[i]].inc

pub fn count_group_by_avx2(a: &[u8]) -> [i64; 256] {
    let mut result: [i64; 256] = [0; 256];
    let mut i = 0;
    unsafe {
        let mask0 = _mm256_set1_epi8(0);
        let mask1 = _mm256_set1_epi8(1);
        let mask2 = _mm256_set1_epi8(2);
        let mask3 = _mm256_set1_epi8(3);
        while i < a.len() - 32 {
            let addr = &a[i];
            let ymm = _mm256_loadu_si256(addr_of!(addr) as *const __m256i);
            if 0 < _popcnt32(_mm256_movemask_epi8(_mm256_cmpgt_epi8(ymm, mask3))) {
                result[_mm256_extract_epi8(ymm, 0) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 1) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 2) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 3) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 4) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 5) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 6) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 7) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 8) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 9) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 10) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 11) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 12) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 13) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 14) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 15) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 16) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 17) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 18) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 19) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 20) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 21) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 22) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 23) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 24) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 25) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 26) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 27) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 28) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 29) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 30) as usize] += 1;
                result[_mm256_extract_epi8(ymm, 31) as usize] += 1;
            } else {
                result[0] += _popcnt32(_mm256_movemask_epi8(_mm256_cmpeq_epi8(ymm, mask0))) as i64;
                result[1] += _popcnt32(_mm256_movemask_epi8(_mm256_cmpeq_epi8(ymm, mask1))) as i64;
                result[2] += _popcnt32(_mm256_movemask_epi8(_mm256_cmpeq_epi8(ymm, mask2))) as i64;
                result[3] += _popcnt32(_mm256_movemask_epi8(_mm256_cmpeq_epi8(ymm, mask3))) as i64;
            }
            i += 32;
        }
    }
    while i < a.len() {
        result[a[i] as usize] += 1;
        i += 1;
    }

    result
}