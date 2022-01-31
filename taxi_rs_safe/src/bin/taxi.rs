use taxi::{count_group_by_avx2};

fn main() {
    let x: [u8; 32] = [0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3,0,1,2,3];

    println!("{:?}", count_group_by_avx2(&x));
}


