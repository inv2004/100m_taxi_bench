CREATE TABLE trips (
  DT Date,
  CT UInt8,
  PC UInt8,
  AM Float32,
  TD Float32
) Engine = MergeTree() PARTITION BY DT ORDER BY DT SETTINGS index_granularity=8192
AS SELECT toDate('2017-01-01')+(number div 380000) as DT, rand()%4 AS CT, rand()%9 AS PC, rand()/50%50 AS AM, rand()/100.0%100 AS TD
     FROM numbers(365*380000);

-- clickhouse-benchmark --query "SELECT COUNT() FROM trips GROUP BY CT"
-- clickhouse-benchmark --query "SELECT PC, avg(AM) FROM trips GROUP BY PC"
-- clickhouse-benchmark --query "SELECT PC, toMonth(DT) AS mon, count() FROM trips GROUP BY PC, mon"
-- clickhouse-benchmark --query "SELECT PC, toMonth(DT) AS mon, round(TD) AS distance, count() FROM trips GROUP BY PC, mon, distance"
