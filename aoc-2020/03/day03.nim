import unittest, strutils, tables, sequtils

proc countTreesPartOne(map: string): int =
  var pos = 0
  result = 0
  for line in map.splitLines:
    if line[pos] == '#':
      result.inc
    pos = (pos + 3) mod 31

proc countTreesPartTwo(map: string): int =
  var treeCounts = initCountTable[int]()
  var row = 0
  for line in map.splitLines:
    for i, mov in [1, 3, 5, 7].pairs:
      if line[(mov * row) mod 31] == '#':
        treeCounts.inc(i) 
    if row mod 2 == 0 and line[(row div 2) mod 31] == '#':
        treeCounts.inc(4)
    row.inc
  result = toSeq(treeCounts.values).foldl(a*b)

when isMainModule:
  const s = readFile("day03.txt").strip
  test "part 1":
    check countTreesPartOne(s) == 214
  test "Part 2":
    check countTreesPartTwo(s) == 8336352024

