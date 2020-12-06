import strutils, unittest

const groups = staticRead("day06.txt").strip.split("\n\n")

proc main(groups: openArray[string]): (int, int) =
  for group in groups:
    var singleReply: set[char]
    var allReply = {'a'..'z'}
    for ans in group.split('\n'):
      var chars: set[char]
      for c in ans: 
        chars.incl(c)
      singleReply = singleReply + chars
      allReply = allReply * chars
    result[0].inc(singleReply.len)
    result[1].inc(allReply.len)

let (p1, p2) = main(groups)
test "part1":
  check p1 == 6534 
test "part2": 
  check p2 == 3402
