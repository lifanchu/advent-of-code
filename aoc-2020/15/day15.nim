import unittest, strutils, tables, bitops, strscans, sequtils
from ../../helpers import benchmark

# read from numbers
# consider most recent number
# if first time spoken, say 0
# else announce distance from prev spoken

type
  Spoken = tuple
    onePrev, twoPrev: int

proc spokenTwice(t: (int, int)): bool =
  result = t[0] != t[1]
  
proc solve(input: seq[int], n: int): int =
  var spoken = initTable[int, Spoken]()
  for i, n in input:
    spoken[n] = (i + 1, i + 1) 
  var lastSpoken = input[^1]
  for i in (input.len+1)..n:
    # let currentNum = input[i mod input.len]
    if not spoken.hasKey(lastSpoken) or not spokenTwice(spoken[lastSpoken]):
      let (twoPrev, onePrev) = spoken[0]
      spoken[0] = (onePrev, i) #overwrite
      lastSpoken = 0
    else:
      let (twoPrev, onePrev) = spoken[lastSpoken]
      lastSpoken = onePrev - twoPrev
      if not spoken.hasKey(lastSpoken):
        spoken[lastSpoken] = (i, i)
      else:
        let (twoPrev, onePrev) = spoken[lastSpoken]
        spoken[lastSpoken] = (onePrev, i) #overwrite
  result = lastSpoken
      
      


when isMainModule:
  const input = staticRead("day15.txt").strip.split(',').map(parseInt)
  
  test "part 1 solution":
    check solve(input, 2020) == 206
  benchmark "":
    test "part 2 solution":
      check solve(input, 30000000) == 955
