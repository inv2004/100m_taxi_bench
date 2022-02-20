import taxi

import criterion
import random

const N = 365*380000
var VEC1 = newSeq[uint8](N)
for x in VEC1.mitems:
  x = uint8 rand(0..3)

var VECI = newSeq[int64](N)
for x in VEC1.mitems:
  x = uint8 rand(0..9)
var VECF = newSeq[float64](N)
for x in VECF.mitems:
  x = rand(0.0..50.0)


var cfg = newDefaultConfig()
# cfg.brief = true
# cfg.verbose = true
cfg.budget = 1.0
cfg.minSamples = 10

benchmark cfg:
  proc countGroupBy() {.measure.} =
    doAssert countGroupBy(VEC1).sum() == N

  # proc countGroupByAVX2() {.measure.} =
  #   doAssert countGroupByAVX2(VEC1).sum() == N

  # proc countGroupByAVX512() {.measure.} =
  #   doAssert countGroupByAVX512(VEC1).sum() == N

  # proc countGroupByAVX512Limited() {.measure.} =
  #   doAssert countGroupByAVX512Limited(VEC1).sum() > 0

  # proc countGroupByAVX512Limited8() {.measure.} =
  #   doAssert countGroupByAVX512Limited8(VEC1).sum() > 0

  proc avgGroupBy() {.measure.} =
    doAssert avgGroupBy(VEC1, VECF)[0].cnt > 0
