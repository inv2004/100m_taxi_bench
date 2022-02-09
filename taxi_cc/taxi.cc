#include <iostream>
#include <vector>
#include <array>
#include <iterator>
#include <random>
#include <chrono>
#include <iomanip>
#include <immintrin.h>

// t:[[]v:`g 1+9710126?2]
// \t:1000 select count by v from t

const int N = 365*380000;

void group1(const std::vector<uint8_t> &v, std::array<int64_t, 256> &g) {
  for(const uint8_t t: v) {
    g[t]++;
  }
}

void group4_with_ymm(const std::vector<uint8_t>& v, std::array<int64_t, 256>& g) {
  using ymm = __m256i;

  int64_t a{0}, b{0}, c{0}, d{0};

  const size_t vsz{std::size(v)};
  size_t idx{0};
  const ymm mask0{_mm256_set1_epi8(0)};
  const ymm mask1{_mm256_set1_epi8(1)};
  const ymm mask2{_mm256_set1_epi8(2)};
  const ymm mask3{_mm256_set1_epi8(3)};

  for (; idx + 32 < vsz; idx += 32) {
    const ymm y{_mm256_loadu_si256(reinterpret_cast<const ymm*>(std::data(v) + idx))};

    if(0 == _mm256_movemask_epi8(_mm256_cmpgt_epi8(y, mask3))) {
      const ymm res0{_mm256_cmpeq_epi8(y, mask0)};
      g[0] += _mm_popcnt_u32(_mm256_movemask_epi8(res0));

      const ymm res1{_mm256_cmpeq_epi8(y, mask1)};
      g[1] += _mm_popcnt_u32(_mm256_movemask_epi8(res1));

      const ymm res2{_mm256_cmpeq_epi8(y, mask2)};
      g[2] += _mm_popcnt_u32(_mm256_movemask_epi8(res2));

      const ymm res3{_mm256_cmpeq_epi8(y, mask3)};
      g[3] += _mm_popcnt_u32(_mm256_movemask_epi8(res3));

    } else {
      g[_mm256_extract_epi8(y, 0)] += 1;
      g[_mm256_extract_epi8(y, 1)] += 1;
      g[_mm256_extract_epi8(y, 2)] += 1;
      g[_mm256_extract_epi8(y, 3)] += 1;
      g[_mm256_extract_epi8(y, 4)] += 1;
      g[_mm256_extract_epi8(y, 5)] += 1;
      g[_mm256_extract_epi8(y, 6)] += 1;
      g[_mm256_extract_epi8(y, 7)] += 1;
      g[_mm256_extract_epi8(y, 8)] += 1;
      g[_mm256_extract_epi8(y, 9)] += 1;
      g[_mm256_extract_epi8(y, 10)] += 1;
      g[_mm256_extract_epi8(y, 11)] += 1;
      g[_mm256_extract_epi8(y, 12)] += 1;
      g[_mm256_extract_epi8(y, 13)] += 1;
      g[_mm256_extract_epi8(y, 14)] += 1;
      g[_mm256_extract_epi8(y, 15)] += 1;
      g[_mm256_extract_epi8(y, 16)] += 1;
      g[_mm256_extract_epi8(y, 17)] += 1;
      g[_mm256_extract_epi8(y, 18)] += 1;
      g[_mm256_extract_epi8(y, 19)] += 1;
      g[_mm256_extract_epi8(y, 20)] += 1;
      g[_mm256_extract_epi8(y, 21)] += 1;
      g[_mm256_extract_epi8(y, 22)] += 1;
      g[_mm256_extract_epi8(y, 23)] += 1;
      g[_mm256_extract_epi8(y, 24)] += 1;
      g[_mm256_extract_epi8(y, 25)] += 1;
      g[_mm256_extract_epi8(y, 26)] += 1;
      g[_mm256_extract_epi8(y, 27)] += 1;
      g[_mm256_extract_epi8(y, 28)] += 1;
      g[_mm256_extract_epi8(y, 29)] += 1;
      g[_mm256_extract_epi8(y, 30)] += 1;
      g[_mm256_extract_epi8(y, 31)] += 1;
    }
  }
  for (; idx < vsz; ++idx) {
    const uint8_t t{v[idx]};
    ++g[t];
  }
}

int main() {
  std::random_device rd; // obtain a random number from hardware
  std::mt19937 gen(rd()); // seed the generator
  std::uniform_int_distribution<> distr(0, 4); // define the range

  std::vector<uint8_t> v = {};
  std::array<int64_t, 256> g = {};

  // for(int i = 0; i < 9710124; i++) {
  for(int i = 0; i < N; i++) {
    v.push_back((uint8_t) distr(gen));
  }

  auto t1 = std::chrono::high_resolution_clock::now();
  group1(v, g);
  auto t2 = std::chrono::high_resolution_clock::now();
  std::chrono::duration<double, std::milli> ns_double = t2 - t1;
  std::cout.precision(10);
  std::cout << "group1 => time: " << ns_double.count() << "ms" << std::endl;
  std::cout << (N == g[0]+g[1]+g[2]+g[3]) << std::endl;

  g = {};
  t1 = std::chrono::high_resolution_clock::now();
  group4_with_ymm(v, g);
  t2 = std::chrono::high_resolution_clock::now();
  ns_double = t2 - t1;
  std::cout << "group4_with_ymm ==> time: " << ns_double.count() << "ns" << std::endl;
  
  std::cout << (N == g[0]+g[1]+g[2]+g[3]) << std::endl;

}
