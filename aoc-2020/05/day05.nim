import unittest, sequtils, algorithm

proc findRow[T](p: openArray[T], l = 0, h = 127): int =
  let mid = (l + h) div 2
  if p.len == 1 :
    result = if p[0] in "FL": l else: h 
  elif p[0] in "FL":
    result = findRow(p[1..p.high], l, mid)
  else:
    result = findRow(p[1..p.high], mid + 1, h)

proc findCol[T](p: openArray[T], l = 0, h = 7): int =
  findRow(p, l, h)
  
proc findSeatNum(s: string): int =
  let row = s[0..6].findRow
  let col = s[7..9].findCol
  (row * 8) + col
  
proc findMySeat(seatsRaw: seq[int]): int =
  let seats = seatsRaw.sorted
  let start = seats[0]
  for s in seats:
    if (start + result) != s:
      return start + result
    else:
      result.inc

when isMainModule:
  let s = toSeq("day05.txt".lines)
  let seatNums = s.map(findSeatNum)

  test "check row finding":
    check findRow("FBFBBFF") == 44
    check findRow("BFFFBBF") == 70
    check findRow("FFFBBBF") == 14 
    check findRow("BBFFBBF") == 102
  test "check column finding":
    check findCol("RRR") == 7
    check findCol("RLL") == 4
  test "seat finding":
    check findSeatNum("BBFFBBFRLL") == 820 
  test "check part 1 solution":
    check seatNums.sorted[^1] == 904
  test "check part 2 solution":
    check findMySeat(seatNums) == 669

