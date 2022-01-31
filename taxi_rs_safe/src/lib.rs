use packed_simd::{u8x32, m8x32, FromCast, Simd};

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
    let mut result: [i64; 256] = [0; 256];
    let mask0 = u8x32::from_slice_unaligned(&[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
    let mask1 = u8x32::from_slice_unaligned(&[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]);
    let mask2 = u8x32::from_slice_unaligned(&[2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]);
    let mask3 = u8x32::from_slice_unaligned(&[3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3]);
    let mut i = 0;
    while i < a.len() - 2 {
        let ymm = u8x32::from_slice_unaligned(&a[i..]);
        if ymm.gt(mask3).any() {
            result[ymm.extract(0) as usize] += 1;
            result[ymm.extract(1) as usize] += 1;
            result[ymm.extract(2) as usize] += 1;
            result[ymm.extract(3) as usize] += 1;
            result[ymm.extract(4) as usize] += 1;
            result[ymm.extract(5) as usize] += 1;
            result[ymm.extract(6) as usize] += 1;
            result[ymm.extract(7) as usize] += 1;
            result[ymm.extract(8) as usize] += 1;
            result[ymm.extract(9) as usize] += 1;
            result[ymm.extract(10) as usize] += 1;
            result[ymm.extract(11) as usize] += 1;
            result[ymm.extract(12) as usize] += 1;
            result[ymm.extract(13) as usize] += 1;
            result[ymm.extract(14) as usize] += 1;
            result[ymm.extract(15) as usize] += 1;
            result[ymm.extract(16) as usize] += 1;
            result[ymm.extract(17) as usize] += 1;
            result[ymm.extract(18) as usize] += 1;
            result[ymm.extract(19) as usize] += 1;
            result[ymm.extract(20) as usize] += 1;
            result[ymm.extract(21) as usize] += 1;
            result[ymm.extract(22) as usize] += 1;
            result[ymm.extract(23) as usize] += 1;
            result[ymm.extract(24) as usize] += 1;
            result[ymm.extract(25) as usize] += 1;
            result[ymm.extract(26) as usize] += 1;
            result[ymm.extract(27) as usize] += 1;
            result[ymm.extract(28) as usize] += 1;
            result[ymm.extract(29) as usize] += 1;
            result[ymm.extract(30) as usize] += 1;
            result[ymm.extract(31) as usize] += 1;
        } else {
            result[0] += if ymm.eq(mask0).any() { 1 } else { 0 };
            result[1] += if ymm.eq(mask1).any() { 1 } else { 0 };
            result[2] += if ymm.eq(mask2).any() { 1 } else { 0 };
            result[3] += if ymm.eq(mask3).any() { 1 } else { 0 };
        }
        i += AVX2WIDTH;
    }
    while i < a.len() {
        result[a[i] as usize] += 1;
        i += 1;
    }

    return result;
}

