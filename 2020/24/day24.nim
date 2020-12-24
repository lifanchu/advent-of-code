import strutils, deques, sets, hashes 

type
  Coord = tuple[x: int, y: int, z: int]
  Grid = tuple[black: HashSet[Coord], white: HashSet[Coord]] 

proc hash(c: Coord): Hash = 
  var h: Hash = 0
  h = c.x !& c.y !& c.z
  result = !$ h

proc traverse[char](s: openArray[char]): Coord = 
  var dirs = s.toDeque
  result = (x: 0, y:0, z:0)
  while dirs.len > 0:
    var dir = $dirs.popFirst()
    if dir != "e" and dir != "w":
      dir &= $dirs.popFirst()
    case dir:
      of "e": 
        result.x.inc
        result.y.dec
      of "w":
        result.x.dec
        result.y.inc
      of "nw":
        result.z.dec
        result.y.inc
      of "ne":
        result.z.dec
        result.x.inc
      of "sw":
        result.x.dec
        result.z.inc
      of "se":
        result.z.inc
        result.y.dec
      else:
        raise newException(ValueError, "Invalid nav string")

proc solve(input: seq[string]): HashSet[Coord] =
  var seen = initHashSet[Coord]()
  for line in input:
    let tile = traverse(line) 
    if seen.contains(tile):
      seen.excl tile
    else:
      seen.incl tile
  result = seen 

proc getNeighbors(tile: Coord): seq[Coord] =
  const offsets = [(0, 1, -1), (1, 0, -1), 
                  (-1, 1, 0), (1, -1, 0), 
                  (-1, 0, 1), (0, -1, 1)]
  for o in offsets:
    result.add (tile.x + o[0], tile.y + o[1], tile[2] + o[2])

proc getWhite(layout: HashSet[Coord]): HashSet[Coord] = 
  for tile in layout:
    for neighbor in tile.getNeighbors():
      if not layout.contains(neighbor):
        result.incl neighbor

proc update(grid: Grid): Grid =
  let black = grid.black
  let white = grid.white
  
  proc countBlackNeighbors(tile: Coord): int =
    for n in tile.getNeighbors():
      if black.contains n: 
        result.inc
    
  for tile in black:
    let blackNeighbors = tile.countBlackNeighbors()
    if blackNeighbors != 1 and blackNeighbors != 2:
      result.white.incl tile
    else:
      result.black.incl tile

  for tile in white:
    let blackNeighbors = tile.countBlackNeighbors()
    if blackNeighbors == 2:
      result.black.incl tile
    else:
      result.white.incl tile
  
  for tile in result.black:
    for n in tile.getNeighbors():
      if not result.black.contains(n):
        result.white.incl n

proc solveTwo(grid: Grid): int =  
  var current = grid
  for i in 0..<100:
    current = update(current)
  result = current[0].len

when isMainModule:
  const input = staticRead("day24.txt").strip.split('\n')

  let black = solve(input)
  let white = black.getWhite()

  echo black.len
  echo solveTwo((black, white))

