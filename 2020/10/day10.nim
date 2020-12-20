import unittest, strutils, sequtils, sets, algorithm

proc findChain(chain: seq[int]): int =
  var onediff, threediff = 0 
  for i in 1..chain.high:
    let diff = chain[i] - chain[i-1]
    if diff == 1: 
      onediff.inc
    elif diff == 3: 
      threediff.inc
  result = onediff * threediff
  
proc isValidChain(chain: seq[int]): bool =
  for i in 1..chain.high:
    if chain[i] - chain[i-1] > 3:
      return false
  result = true

proc findArrangements(chain: seq[int]): HashSet[seq[int]] =
  result.incl chain
  for i in 1..chain.high - 1:
    var testChain = chain
    testChain.delete(i)
    if testChain.isValidChain:
      result.incl findArrangements(testChain)

proc divideAndConquer(chain: seq[int]): int =
  #to reduce complexity, split into independent 'islands'
  #then multiply them together later
  var islands: seq[seq[int]]
  var prevIndex = 0
  for i in 1..chain.high:
    if chain[i] - chain[i-1] == 3:
      islands &= chain[prevIndex..i-1]
      prevIndex = i
    elif i == chain.high: #add final island
      islands &= chain[prevIndex..chain.high]
  result = 1
  for island in islands:
    result *= island.findArrangements.len


when isMainModule:
  const s = staticRead("day10.txt").strip.split('\n').map(parseInt).sorted
  var chain = @[0] & s & @[s[^1] + 3]
  test "Check independent arrangements":
    check findArrangements(@[5, 6, 7, 8]).len == 4
    check findArrangements(@[0, 1, 2]).len == 2
  test "Check interaction of independent arrangements":
    let vec = @[0, 1, 2, 5, 6, 7, 8]
    check findArrangements(vec).len == 8 
    check findArrangements(vec).len == divideAndConquer(vec)
  test "Part 1 solution":
    check findChain(chain) == 2414
  test "Part 2 solution":
    check divideAndConquer(chain) == 21156911906816
    
