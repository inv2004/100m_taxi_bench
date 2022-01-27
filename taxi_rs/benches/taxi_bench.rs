use taxi::*;

use criterion::{criterion_group, criterion_main, Criterion};
use rand::{thread_rng, Rng};
#[macro_use] extern crate lazy_static;

const N: i64 = 365*380000;

lazy_static! {
    static ref VEC1: Vec<u8> = (0..N).map(|_| thread_rng().gen_range(0..3)).collect();
}

fn bench_count_group_by(c: &mut Criterion) {
    c.bench_function("count_by_group", |b| b.iter(|| assert_eq!(sum(&count_group_by(&VEC1)), N)));
}

fn bench_count_group_by_avx2(c: &mut Criterion) {
    c.bench_function("count_by_group_avx2", |b| b.iter(|| assert_eq!(sum(&count_group_by_avx2(&VEC1)), N)));
}

criterion_group!(benches, bench_count_group_by, bench_count_group_by_avx2);
criterion_main!(benches);
