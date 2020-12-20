import strutils, strscans, unittest

proc checkPasswords(f: string): (int, int) =
  var
    first, second: int
    c, pass: string
  for line in f.lines:
    if scanf(line, "$i-$i $w: $w", first, second, c, pass):
      let freq = count(pass, c[0])
      if freq in first..second:
        result[0].inc
      if pass[first-1]==c[0] xor pass[second-1]==c[0]:
        result[1].inc

when isMainModule:
  let solutions = checkPasswords("day02.txt")
  test "part 1":
    check solutions[0] == 556
  test "part 2":
    check solutions[1] == 605 