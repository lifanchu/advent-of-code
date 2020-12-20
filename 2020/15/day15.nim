import unittest, strutils, tables, sequtils
from ../../helpers import benchmark

proc solve(input: seq[int], n: int): int =
  var spoken = initTable[int, (int, int)]()

  for i, n in input:
    spoken[n] = (i + 1, i + 1) 
  var lastSpoken = input[^1]

  for i in (input.len+1)..n:
    let newSpoken = 
      if not spoken.hasKey(lastSpoken):
        0
      else:
        let (twoPrev, onePrev) = spoken[lastSpoken]
        onePrev - twoPrev
    spoken[newSpoken] =
      if not spoken.hasKey(newSpoken):
        (i, i)
      else:
        (spoken[newSpoken][1], i)
    lastSpoken = newSpoken

  result = lastSpoken
      
when isMainModule:
  const input = staticRead("day15.txt").strip.split(',').map(parseInt)
  
  test "part 1 solution":
    check solve(input, 2020) == 206
  benchmark "":
    test "part 2 solution":
      check solve(input, 30000000) == 955
