use criterion::{criterion_group, criterion_main, Criterion};
use rand::{thread_rng, Rng};
#[macro_use] extern crate lazy_static;

lazy_static! {
    static ref VEC1: Vec<u8> = (0..365*380000).map(|_| thread_rng().gen_range(0..3)).collect();
}

fn count_group_by(a: &[u8]) -> [i64; 256] {
    let mut result = [0; 256];
    for &x in a {
        result[x as usize] += 1;
    }
    result
}

fn criterion_benchmark(c: &mut Criterion) {
    c.bench_function("count_by_group", |b| b.iter(|| count_group_by(&VEC1)[0] > 0));
}

criterion_group!(benches, criterion_benchmark);
criterion_main!(benches);

