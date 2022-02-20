# 100 Millions Taxi Rides benchmark

**Blog Post:** https://t.me/inv2004_dev_blog/39

Simplified and fixed implementation of the benchmark: https://tech.marksblogg.com/benchmarks.html

365 days x 380000 rows x 10 bytes => ~1.387Gb

CPU: 12th Gen Intel(R) Core(TM) i5-12600

time in ms:

|    | k9  | q -s 1 | q -s 12 | clickhouse | nim-naive | nim avx2 | nim avx512 |
|----|-----|--------|---------|------------|-----------|----------|------------|
| q1 | 16  | 67     | 13      | 15         | 37        | 8        | 6          |
| q2 | 98  | 426    | 71      | 30         | 80        | nyi      | nyi        |
| q3 | 33  | 48     | 11      | 26         | nyi       | nyi      | nyi        |
| q4 | nyi | 787    | 436     | 70         | nyi       | nyi      | nyi        |

## Old
CPU: Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz DDR 2666

time in ms:

|    | k9  | q -s 1 | q -s 4 | clickhouse |
|----|-----|--------|--------|------------|
| q1 | 28  | 102    | 30     | 92         |
| q2 | 176 | 440    | 148    | 238        |
| q3 | 60  | 92     | 28     | 217        |
| q4 | nyi | 1523   | 1000   | 752        |

* k9 li 2021.10.21 2 12 (c)shakti 2.0 *express license (single-threaded)
* KDB+ 4.0 2021.07.12 l64/ 4(16)core
* ClickHouse version 21.12.3.32

## TODO
- not sure about k9-q3 results
- would be good to retest q with parted mem-data like k9
