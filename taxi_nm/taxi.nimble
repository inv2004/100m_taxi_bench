# Package

version       = "0.1.0"
author        = "inv2004"
description   = "100m taxi bench q1"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.2"
requires "unroll"

task bench, "bench":
  exec """nim c --opt:speed --passC:'-flto -march=native -Ofast' --passL:'-flto -march=native -Ofast' -d:danger --cc:clang -r bench/taxi_bench.nim"""
