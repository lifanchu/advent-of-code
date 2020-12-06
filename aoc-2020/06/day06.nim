import strutils, sequtils, unittest

const groups = staticRead("day06.txt").strip.split("\n\n")

proc main[T](groups: openArray[T]): (int, int) =
  for group in groups:
    var unique: set[char]
    var unique2 = {'a'..'z'}
    for ans in group.split('\n'):
      var chars: set[char]
      for c in ans: 
        chars.incl(c)
      unique = unique + chars
      unique2 = unique2 * chars
    result[0].inc(unique.len)
    result[1].inc(unique2.len)

test "part1":
  check main(groups)[0]==6534 
test "part2": 
  check main(groups)[1]==3402
