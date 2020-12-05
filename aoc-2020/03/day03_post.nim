import unittest, tables, sequtils

proc travel(grid: seq[string], movs: openArray[(int, int)]): int =
  var treeCounts = initCountTable[int]()
  let w = grid[0].len
  for row in 0..grid.high:
    for i in 0..movs.high: 
      let dx = movs[i][0] 
      let dy = movs[i][1] 
      if row mod dy == 0:
        if grid[row][(dx*(row div dy)) mod w] == '#':
          treeCounts.inc(i)
  result = toSeq(treeCounts.values).foldl(a*b)

when isMainModule:
  let 
    m = toSeq("day03.txt".lines)
    movs = [(1,1), (3,1), (5,1), (7,1), (1,2)]
  test "part 1":
    check travel(m, [(3, 1)]) == 214
  test "Part 2":
    check travel(m, movs) == 8336352024

