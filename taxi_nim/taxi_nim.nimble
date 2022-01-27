# Package

version       = "0.1.0"
author        = "alexander"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["taxi_nim"]


# Dependencies

requires "nim >= 1.6.2"

task bench, "bench":
  exec """nim c --opt:speed --passC:'-flto -march=native -Ofast' --passL:'-flto -march=native -Ofast' -d:danger -r bench/taxi_bench.nim"""
