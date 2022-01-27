import taxi

import criterion
import random

const N = 365*380000
var VEC1 = newSeq[uint8](N)
for x in VEC1.mitems:
  x = uint8 rand(0..3)

var cfg = newDefaultConfig()
# cfg.brief = true
# cfg.verbose = true
cfg.budget = 1.0
cfg.minSamples = 10

benchmark cfg:
  proc countGroupBy() {.measure.} =
    doAssert countGroupBy(VEC1).sum() == N

  proc countGroupByAVX2() {.measure.} =
    doAssert countGroupByAVX2(VEC1).sum() == N
