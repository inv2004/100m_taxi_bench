# 100 Millions Taxi Rides Benchmark

CPU: Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz DDR 2666

365 days x 380000 rows x 10 bytes => ~1.387Gb

time in ms:

|    | k9  | q -s 4 | clickhouse |
|----|-----|--------|------------|
| q1 | 28  | 31     | 92         |
| q2 | 176 | 148    | 238        |
| q3 | 60  | 28     | 217        |
| q4 | nyi | 1000   | 752        |


* k9 li 2021.10.21 2 12 (c)shakti 2.0
* KDB+ 4.0 2021.07.12 l64/ 4(16)core
* ClickHouse version 21.12.3.32
