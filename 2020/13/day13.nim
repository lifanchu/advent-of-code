import unittest, strutils, tables, sequtils

proc solve1(stamp: int, buses: seq[(int, int)]): int =
  var start = stamp
  let (busIDs, _) = buses.unzip()
  while true: 
    for bus in busIDs:
      if start mod bus == 0:
        return bus * (start - stamp)
    start.inc
        
proc mulInv(a0, b0: int): int =
  var (a, b, x0) = (a0, b0, 0)
  result = 1
  if b == 1: return
  while a > 1:
    let q = a div b
    a = a mod b
    swap a, b
    result = result - q * x0
    swap x0, result
  if result < 0: result += b0

proc chineseRemainder[T](n, a: T): int =
  var prod = 1
  var sum = 0
  for x in n: prod *= x
 
  for i in 0..<n.len:
    let p = prod div n[i]
    sum += a[i] * mulInv(p, n[i]) * p
 
  sum mod prod

proc solve2(buses: seq[(int, int)]): int =
  let (ids, offsets) = buses.unzip()        
  chineseRemainder(ids, offsets)

proc parse(s: seq[string]): (int, seq[(int, int)]) =
  result[0] = s[0].parseInt
  let raw_buses = s[1].strip.split(',')
  for i, b in raw_buses:
      if b != "x":
        let val = parseInt(b)
        result[1].add (val, val - i)
    
when isMainModule:
    const s = staticRead("day13.txt").strip.split('\n')
    var (stamp, buses) =  parse(s) 

    test "part 1":
        check solve1(stamp, buses) == 138
    test "part 2":
        check solve2(buses) == 226845233210288


