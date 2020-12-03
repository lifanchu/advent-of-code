import strutils, strscans, unittest

var
  first, second: int
  c: string
  pass: string

proc checkPasswordsPart1(f: string): int =
  result = 0
  for line in f.splitLines:
    if scanf(line, "$i-$i $w: $w", first, second, c, pass):
      let freq = count(pass, c[0])
      if freq >= first and freq <= second:
        result.inc

proc checkPasswordsPart2(f: string): int =
  result = 0
  for line in f.splitLines:
    if scanf(line, "$i-$i $w: $w", first, second, c, pass):
      if pass[first-1]==c[0] xor pass[second-1]==c[0]:
        result.inc

when isMainModule:

  const f = readFile("inputs/day02.txt")

  test "with full input":
    check checkPasswordsPart1(f) == 556
    check checkPasswordsPart2(f) == 605 