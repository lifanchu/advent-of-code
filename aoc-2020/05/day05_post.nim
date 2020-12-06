import unittest, sequtils, algorithm, parseutils, strutils

proc findSeatNum(s: string): int =
  discard s.multiReplace(
    replacements = [("F", "0"), ("B", "1"), ("L", "0"), ("R", "1")]).
    parseBin(result)

proc findMySeat(seatsRaw: seq[int]): int =
  let seats = seatsRaw.sorted
  let start = seats[0]
  for i, sid in seats:
    if start + i != sid:
      return start + i

when isMainModule:
  let seatNums = toSeq("day05.txt".lines).map(findSeatNum)
  test "seat finding":
    check findSeatNum("BBFFBBFRLL") == 820 
  test "check part 1 solution":
    check seatNums.sorted[^1] == 904
  test "check part 2 solution":
    check findMySeat(seatNums) == 669

