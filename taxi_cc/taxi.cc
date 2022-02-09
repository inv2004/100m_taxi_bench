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

constexpr void inc(uint8_t c, std::array<int64_t, 256> &g) {
  switch(c) {
    case 0: g[0] += 1; break;
    case 1: g[1] += 1; break;
    case 2: g[2] += 1; break;
    case 3: g[3] += 1; break;
    case 4: g[4] += 1; break;
    case 5: g[5] += 1; break;
    case 6: g[6] += 1; break;
    case 7: g[7] += 1; break;
    case 8: g[8] += 1; break;
    case 9: g[9] += 1; break;
    case 10: g[10] += 1; break;
    case 11: g[11] += 1; break;
    case 12: g[12] += 1; break;
    case 13: g[13] += 1; break;
    case 14: g[14] += 1; break;
    case 15: g[15] += 1; break;
    case 16: g[16] += 1; break;
    case 17: g[17] += 1; break;
    case 18: g[18] += 1; break;
    case 19: g[19] += 1; break;
    case 20: g[20] += 1; break;
    case 21: g[21] += 1; break;
    case 22: g[22] += 1; break;
    case 23: g[23] += 1; break;
    case 24: g[24] += 1; break;
    case 25: g[25] += 1; break;
    case 26: g[26] += 1; break;
    case 27: g[27] += 1; break;
    case 28: g[28] += 1; break;
    case 29: g[29] += 1; break;
    case 30: g[30] += 1; break;
    case 31: g[31] += 1; break;
    case 32: g[32] += 1; break;
    case 33: g[33] += 1; break;
    case 34: g[34] += 1; break;
    case 35: g[35] += 1; break;
    case 36: g[36] += 1; break;
    case 37: g[37] += 1; break;
    case 38: g[38] += 1; break;
    case 39: g[39] += 1; break;
    case 40: g[40] += 1; break;
    case 41: g[41] += 1; break;
    case 42: g[42] += 1; break;
    case 43: g[43] += 1; break;
    case 44: g[44] += 1; break;
    case 45: g[45] += 1; break;
    case 46: g[46] += 1; break;
    case 47: g[47] += 1; break;
    case 48: g[48] += 1; break;
    case 49: g[49] += 1; break;
    case 50: g[50] += 1; break;
    case 51: g[51] += 1; break;
    case 52: g[52] += 1; break;
    case 53: g[53] += 1; break;
    case 54: g[54] += 1; break;
    case 55: g[55] += 1; break;
    case 56: g[56] += 1; break;
    case 57: g[57] += 1; break;
    case 58: g[58] += 1; break;
    case 59: g[59] += 1; break;
    case 60: g[60] += 1; break;
    case 61: g[61] += 1; break;
    case 62: g[62] += 1; break;
    case 63: g[63] += 1; break;
    case 64: g[64] += 1; break;
    case 65: g[65] += 1; break;
    case 66: g[66] += 1; break;
    case 67: g[67] += 1; break;
    case 68: g[68] += 1; break;
    case 69: g[69] += 1; break;
    case 70: g[70] += 1; break;
    case 71: g[71] += 1; break;
    case 72: g[72] += 1; break;
    case 73: g[73] += 1; break;
    case 74: g[74] += 1; break;
    case 75: g[75] += 1; break;
    case 76: g[76] += 1; break;
    case 77: g[77] += 1; break;
    case 78: g[78] += 1; break;
    case 79: g[79] += 1; break;
    case 80: g[80] += 1; break;
    case 81: g[81] += 1; break;
    case 82: g[82] += 1; break;
    case 83: g[83] += 1; break;
    case 84: g[84] += 1; break;
    case 85: g[85] += 1; break;
    case 86: g[86] += 1; break;
    case 87: g[87] += 1; break;
    case 88: g[88] += 1; break;
    case 89: g[89] += 1; break;
    case 90: g[90] += 1; break;
    case 91: g[91] += 1; break;
    case 92: g[92] += 1; break;
    case 93: g[93] += 1; break;
    case 94: g[94] += 1; break;
    case 95: g[95] += 1; break;
    case 96: g[96] += 1; break;
    case 97: g[97] += 1; break;
    case 98: g[98] += 1; break;
    case 99: g[99] += 1; break;
    case 100: g[100] += 1; break;
    case 101: g[101] += 1; break;
    case 102: g[102] += 1; break;
    case 103: g[103] += 1; break;
    case 104: g[104] += 1; break;
    case 105: g[105] += 1; break;
    case 106: g[106] += 1; break;
    case 107: g[107] += 1; break;
    case 108: g[108] += 1; break;
    case 109: g[109] += 1; break;
    case 110: g[110] += 1; break;
    case 111: g[111] += 1; break;
    case 112: g[112] += 1; break;
    case 113: g[113] += 1; break;
    case 114: g[114] += 1; break;
    case 115: g[115] += 1; break;
    case 116: g[116] += 1; break;
    case 117: g[117] += 1; break;
    case 118: g[118] += 1; break;
    case 119: g[119] += 1; break;
    case 120: g[120] += 1; break;
    case 121: g[121] += 1; break;
    case 122: g[122] += 1; break;
    case 123: g[123] += 1; break;
    case 124: g[124] += 1; break;
    case 125: g[125] += 1; break;
    case 126: g[126] += 1; break;
    case 127: g[127] += 1; break;
    case 128: g[128] += 1; break;
    case 129: g[129] += 1; break;
    case 130: g[130] += 1; break;
    case 131: g[131] += 1; break;
    case 132: g[132] += 1; break;
    case 133: g[133] += 1; break;
    case 134: g[134] += 1; break;
    case 135: g[135] += 1; break;
    case 136: g[136] += 1; break;
    case 137: g[137] += 1; break;
    case 138: g[138] += 1; break;
    case 139: g[139] += 1; break;
    case 140: g[140] += 1; break;
    case 141: g[141] += 1; break;
    case 142: g[142] += 1; break;
    case 143: g[143] += 1; break;
    case 144: g[144] += 1; break;
    case 145: g[145] += 1; break;
    case 146: g[146] += 1; break;
    case 147: g[147] += 1; break;
    case 148: g[148] += 1; break;
    case 149: g[149] += 1; break;
    case 150: g[150] += 1; break;
    case 151: g[151] += 1; break;
    case 152: g[152] += 1; break;
    case 153: g[153] += 1; break;
    case 154: g[154] += 1; break;
    case 155: g[155] += 1; break;
    case 156: g[156] += 1; break;
    case 157: g[157] += 1; break;
    case 158: g[158] += 1; break;
    case 159: g[159] += 1; break;
    case 160: g[160] += 1; break;
    case 161: g[161] += 1; break;
    case 162: g[162] += 1; break;
    case 163: g[163] += 1; break;
    case 164: g[164] += 1; break;
    case 165: g[165] += 1; break;
    case 166: g[166] += 1; break;
    case 167: g[167] += 1; break;
    case 168: g[168] += 1; break;
    case 169: g[169] += 1; break;
    case 170: g[170] += 1; break;
    case 171: g[171] += 1; break;
    case 172: g[172] += 1; break;
    case 173: g[173] += 1; break;
    case 174: g[174] += 1; break;
    case 175: g[175] += 1; break;
    case 176: g[176] += 1; break;
    case 177: g[177] += 1; break;
    case 178: g[178] += 1; break;
    case 179: g[179] += 1; break;
    case 180: g[180] += 1; break;
    case 181: g[181] += 1; break;
    case 182: g[182] += 1; break;
    case 183: g[183] += 1; break;
    case 184: g[184] += 1; break;
    case 185: g[185] += 1; break;
    case 186: g[186] += 1; break;
    case 187: g[187] += 1; break;
    case 188: g[188] += 1; break;
    case 189: g[189] += 1; break;
    case 190: g[190] += 1; break;
    case 191: g[191] += 1; break;
    case 192: g[192] += 1; break;
    case 193: g[193] += 1; break;
    case 194: g[194] += 1; break;
    case 195: g[195] += 1; break;
    case 196: g[196] += 1; break;
    case 197: g[197] += 1; break;
    case 198: g[198] += 1; break;
    case 199: g[199] += 1; break;
    case 200: g[200] += 1; break;
    case 201: g[201] += 1; break;
    case 202: g[202] += 1; break;
    case 203: g[203] += 1; break;
    case 204: g[204] += 1; break;
    case 205: g[205] += 1; break;
    case 206: g[206] += 1; break;
    case 207: g[207] += 1; break;
    case 208: g[208] += 1; break;
    case 209: g[209] += 1; break;
    case 210: g[210] += 1; break;
    case 211: g[211] += 1; break;
    case 212: g[212] += 1; break;
    case 213: g[213] += 1; break;
    case 214: g[214] += 1; break;
    case 215: g[215] += 1; break;
    case 216: g[216] += 1; break;
    case 217: g[217] += 1; break;
    case 218: g[218] += 1; break;
    case 219: g[219] += 1; break;
    case 220: g[220] += 1; break;
    case 221: g[221] += 1; break;
    case 222: g[222] += 1; break;
    case 223: g[223] += 1; break;
    case 224: g[224] += 1; break;
    case 225: g[225] += 1; break;
    case 226: g[226] += 1; break;
    case 227: g[227] += 1; break;
    case 228: g[228] += 1; break;
    case 229: g[229] += 1; break;
    case 230: g[230] += 1; break;
    case 231: g[231] += 1; break;
    case 232: g[232] += 1; break;
    case 233: g[233] += 1; break;
    case 234: g[234] += 1; break;
    case 235: g[235] += 1; break;
    case 236: g[236] += 1; break;
    case 237: g[237] += 1; break;
    case 238: g[238] += 1; break;
    case 239: g[239] += 1; break;
    case 240: g[240] += 1; break;
    case 241: g[241] += 1; break;
    case 242: g[242] += 1; break;
    case 243: g[243] += 1; break;
    case 244: g[244] += 1; break;
    case 245: g[245] += 1; break;
    case 246: g[246] += 1; break;
    case 247: g[247] += 1; break;
    case 248: g[248] += 1; break;
    case 249: g[249] += 1; break;
    case 250: g[250] += 1; break;
    case 251: g[251] += 1; break;
    case 252: g[252] += 1; break;
    case 253: g[253] += 1; break;
    case 254: g[254] += 1; break;
    case 255: g[255] += 1; break;
  }
}

void group2(const std::vector<uint8_t> &v, std::array<int64_t, 256> &g) {
  for(const uint8_t t: v) {
    inc(t, g);
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
      for(int off = idx; off < idx+32; off += 1) {
        g[v[off]] += 1;
      }
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
  std::uniform_int_distribution<> distr(0, 3); // define the range

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
  group2(v, g);
  t2 = std::chrono::high_resolution_clock::now();
  ns_double = t2 - t1;
  std::cout << "group2 ==> time: " << ns_double.count() << "ns" << std::endl;
  std::cout << (N == g[0]+g[1]+g[2]+g[3]) << std::endl;

  g = {};
  t1 = std::chrono::high_resolution_clock::now();
  group4_with_ymm(v, g);
  t2 = std::chrono::high_resolution_clock::now();
  ns_double = t2 - t1;
  std::cout << "group4_with_ymm ==> time: " << ns_double.count() << "ns" << std::endl;
  std::cout << (N == g[0]+g[1]+g[2]+g[3]) << std::endl;

}
