import strutils

const s = readFile("./inputs/01.txt").strip

proc stringToInts(s: string): seq[int] =
  for line in s.splitLines:
    result.add line.parseInt

proc fixExpenses(nums: seq[int]): int =
  for i in nums:
    for j in nums:
      if i + j == 2020:
        return i * j

proc fixExpensesPart2(nums: seq[int]): int =
  for i in nums:
    for j in nums:
      for k in nums:
        if i + j + k == 2020:
          return i * j * k

when isMainModule:
  import unittest

  var nums = stringToInts(s)
  let part1 = fixExpenses(nums)
  test "part1":
    check part1 == 988771

  let part2 = fixExpensesPart2(nums)
  echo fixExpensesPart2(nums)
  # test "part2":
  #   discard

  test "lol":
    let foo = stringToInts("123\n456\n-42")
    check foo == @[123, 456, -42]
