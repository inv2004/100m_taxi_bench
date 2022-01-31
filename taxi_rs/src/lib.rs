use core::arch::x86_64::{__m256i, _mm256_set1_epi8, _mm256_loadu_si256, _mm256_cmpgt_epi8, _mm256_cmpeq_epi8, _mm256_movemask_epi8, _popcnt32, _mm256_extract_epi8};
use  std::ptr::addr_of;
use seq_macro::seq;

const AVX2WIDTH: usize = 32;

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

pub fn count_group_by_avx2(a: &[u8]) -> [i64; 256] {
    unsafe { count_group_by_avx2_unsafe(a) }
}


#[cfg(all(target_feature = "avx2", target_feature = "popcnt"))]
pub unsafe fn count_group_by_avx2_unsafe(a: &[u8]) -> [i64; 256] {
    let mut result: [i64; 256] = [0; 256];
    let mask0 = _mm256_set1_epi8(0);
    let mask1 = _mm256_set1_epi8(1);
    let mask2 = _mm256_set1_epi8(2);
    let mask3 = _mm256_set1_epi8(3);
    let mut i = 0;
    while i < a.len() - AVX2WIDTH {
        let ymm = _mm256_loadu_si256(addr_of!(a[i]) as *const __m256i);
        if 0 < _popcnt32(_mm256_movemask_epi8(_mm256_cmpgt_epi8(ymm, mask3))) {
            seq!(N in 0..32 {
                result[_mm256_extract_epi8(ymm, N) as usize] += 1;
            });
        } else {
            result[0] += _popcnt32(_mm256_movemask_epi8(_mm256_cmpeq_epi8(ymm, mask0))) as i64;
            result[1] += _popcnt32(_mm256_movemask_epi8(_mm256_cmpeq_epi8(ymm, mask1))) as i64;
            result[2] += _popcnt32(_mm256_movemask_epi8(_mm256_cmpeq_epi8(ymm, mask2))) as i64;
            result[3] += _popcnt32(_mm256_movemask_epi8(_mm256_cmpeq_epi8(ymm, mask3))) as i64;
        }
        i += AVX2WIDTH;
    }
    while i < a.len() {
        result[a[i] as usize] += 1;
        i += 1;
    }

    result
}
