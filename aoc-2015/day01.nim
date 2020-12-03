import tables, strutils

let s = readFile("./inputs/day01.txt").strip

type
  Solution = tuple
    part1: int
    part2: int

proc santaClimb*(s: string): Solution =
  var floor = 0
  for i in 0..s.high:
    if s[i] == '(':
      floor.inc
    else:
      floor.dec
    if floor == -1 and result.part2 == 0:
      result.part2 = i + 1
  result.part1 = floor

when isMainModule:
  import unittest
  let (part1, part2) = santaClimb(s)
  suite "day01":
    test "part1":
      check part1 == 74
    test "part2":
      check part2 == 1795