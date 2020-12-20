import unittest, strutils, tables, sequtils
from ../../helpers import benchmark

proc solve(input: seq[int], limit: int): int =
  var spoken = initTable[int, int]()
  for i, n in input: 
    spoken[n] = i + 1 
  for i in input.len+1..limit:
    let next = i - spoken.getOrDefault(i, n)

  result = lastSpoken
      
when isMainModule:
  const input = staticRead("day15.txt").strip.split(',').map(parseInt)
  
  test "part 1 solution":
    check solve(input, 2020) == 206
  benchmark "":
    test "part 2 solution":
      check solve(input, 30000000) == 955
