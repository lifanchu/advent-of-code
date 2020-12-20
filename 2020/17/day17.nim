import unittest, strutils, tables, hashes

type
  Grid = Table[Coord, bool]
  Grid2 = Table[Coord2, bool]
  
  Coord = tuple
    x, y, z: int
  Coord2 = tuple
    x, y, z, w: int

proc getNeighborCoords(c: Coord): seq[Coord] =
  for x in -1..1:
    for y in -1..1:
      for z in -1..1:
        let coord = (c.x + x, c.y + y, c.z + z)
        if c != coord:
          result.add coord

proc boot(grid: Grid): Grid =
  var startGrid = grid
  for existing in grid.keys:
    for possible in existing.getNeighborCoords:
      if not startGrid.contains(possible):
        startGrid[possible] = false

  result = startGrid
  for coord in startGrid.keys:
    let activeNeighbors = block:
      var count = 0
      for n in coord.getNeighborCoords:
        if startGrid.contains(n) and startGrid[n] == true:
          count.inc
      count 
    let active = startGrid[coord]
    case active:
      of true:
        if not (activeNeighbors == 2 or activeNeighbors == 3):
          result[coord] = false
      of false:
        if activeNeighbors == 3:
          result[coord] = true

proc solve1(grid: Grid): int =
  var prevGrid = grid
  var nextGrid: Grid
  for i in 0..<6:
    nextGrid = boot(prevGrid)
    prevGrid = nextGrid

  for coord in nextGrid.keys:
    if nextGrid[coord]:
      result.inc 
      
proc getNeighborCoords2(c: Coord2): seq[Coord2] =
  for x in -1..1:
    for y in -1..1:
      for z in -1..1:
        for w in -1..1:
          let coord = (c.x + x, c.y + y, c.z + z, c.w + w)
          if c != coord:
            result.add coord

proc boot2(grid: Grid2): Grid2 =
  var startGrid = grid
  for existing in grid.keys:
    for possible in existing.getNeighborCoords2:
      if not startGrid.contains(possible):
        startGrid[possible] = false

  result = startGrid
  for coord in startGrid.keys:
    let activeNeighbors = block:
      var count = 0
      for n in coord.getNeighborCoords2:
        if startGrid.contains(n) and startGrid[n] == true:
          count.inc
      count 
    let active = startGrid[coord]
    case active:
      of true:
        if not (activeNeighbors == 2 or activeNeighbors == 3):
          result[coord] = false
      of false:
        if activeNeighbors == 3:
          result[coord] = true

proc solve2(grid: Grid2): int =
  var prevGrid = grid
  var nextGrid: Grid2
  for i in 0..<6:
    nextGrid = boot2(prevGrid)
    prevGrid = nextGrid

  for coord in nextGrid.keys:
    if nextGrid[coord]:
      result.inc 

proc parse(s: seq[string]): Grid =
  for i in 0..s.high:
    for j in 0..s[0].high:
      let active = s[i][j] == '#'
      result[(j, i, 0)] = active

proc parse2(s: seq[string]): Grid2 =
  for i in 0..s.high:
    for j in 0..s[0].high:
      let active = s[i][j] == '#'
      result[(j, i, 0, 0)] = active

when isMainModule:
  const s = staticRead("day17.txt").strip.split('\n')

  test "part 1 solution":
    check solve1(parse(s)) == 255
  test "part 2 solution":
    check solve2(parse2(s)) == 2340
