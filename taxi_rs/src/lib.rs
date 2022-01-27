
pub fn count_group_by(a: &[u8]) -> [i64; 256] {
    let mut result = [0; 256];
    for &x in a {
        result[x as usize] += 1;
    }
    result
}
