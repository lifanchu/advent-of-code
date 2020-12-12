import unittest, strutils, tables
from ../../helpers import benchmark

type
  Action = enum
    East, South, West, North, Left, Right, Forward
  Ship = object
    facing, x, y, wx, wy: int 
  Coord = tuple
    x, y: int

proc rotate(deg: int, amount: int): int =
  result = deg + amount
  if result >= 360:
    result.dec 360
  elif result < 0:
    result = 360 + result
    
proc rotateLong(center: Coord, point: Coord, amount: int): Coord =
  #re-center, rotate, de-center
  let cx = point.x - center.x 
  let cy = point.y - center.y
  let theta = if amount < 0: 360 + amount else: amount
  case theta:
    of 180: result = (cx * -1, cy * -1)
    of 90: result = (cy, cx * -1)
    of 270: result = (cy * -1, cx)
    else: result = (cx, cy)
  result[0].inc center.x
  result[1].inc center.y


proc manipulateShip(ship: Ship, command: (Action, int)): Ship =
  result = ship
  let val = command[1]
  case command[0]:
    of North: result.y.inc val
    of South: result.y.dec val
    of East: result.x.inc val
    of West: result.x.dec val
    of Left: result.facing = rotate(result.facing, val * -1) 
    of Right: result.facing = rotate(result.facing, val)
    of Forward:
      var dir: Action
      case result.facing:
        of 0: dir = North 
        of 90: dir = East 
        of 180: dir = South 
        of 270: dir = West 
        else: discard
      result = manipulateShip(result, (dir, val))

proc waypointTravel(ship: Ship, command: (Action, int)): Ship =
  result = ship
  var val = command[1]
  let shipLoc = (ship.x, ship.y)
  let wayLoc = (ship.wx, ship.wy)
  case command[0]:
    of North: result.wy.inc val
    of South: result.wy.dec val
    of East: result.wx.inc val
    of West: result.wx.dec val
    of Left, Right:
      val = if command[0] == Left: val * -1 else: val 
      (result.wx, result.wy) = rotateLong(shipLoc, wayLoc, val)
    of Forward:
      let xdiff = (result.wx - result.x) * val
      let ydiff = (result.wy - result.y) * val
      result.x.inc  xdiff
      result.wx.inc xdiff 
      result.y.inc  ydiff
      result.wy.inc ydiff
      
proc solve(ship: Ship, dirs: seq[(Action, int)]): (int, int) =
  var shipOne, shipTwo = ship
  for dir in dirs:
    shipOne = shipOne.manipulateShip(dir)
    shipTwo = shipTwo.waypointTravel(dir)
  result[0] = abs(shipOne.x) + abs(shipOne.y)
  result[1] = abs(shipTwo.x) + abs(shipTwo.y)
    
proc parse[T](s: openArray[T]): seq[(Action, int)] =
  const actTable = [('N', North), ('E', East), ('W', West), ('S', South),
                  ('L', Left), ('R', Right), ('F', Forward)].toTable
  for i, action in s:
    var act = action[0]
    var val = parseInt($action[1..action.high])
    result.add (actTable[act], val)

when isMainModule:
  benchmark "":
    const dirs = readFile("day12.txt").strip.split('\n').parse()
    const ship = Ship(facing: 90, x: 0, y: 0, wx: 10, wy: 1)
    let solutions =  solve(ship, dirs)

    test "part 1 solution":
      check solutions[0] == 2458
    test "part 2 solution":
      check solutions[1] == 145117
