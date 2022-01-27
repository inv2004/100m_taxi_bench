import criterion
import random

var VEC1 = newSeq[uint8](365*380000)
for x in VEC1.mitems:
  x = uint8 rand(0..3)

func countGroupBy(a: openArray[uint8]): array[256, int] =
  for x in a:
    inc result[x]

var cfg = newDefaultConfig()
# cfg.brief = true
cfg.verbose = true
cfg.budget = 1.0
cfg.minSamples = 10

benchmark cfg:
  proc mergedCounter() {.measure.} =
    doAssert countGroupBy(VEC1)[0] > 0

