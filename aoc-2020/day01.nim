import strutils, unittest

proc stringToInts(s: string): seq[int] =
  for line in s.splitLines:
    result.add line.parseInt

proc fixExpenses(nums: seq[int]): int =
  for i in 0..nums.high:
    for j in i+1..nums.high:
      if nums[i] + nums[j] == 2020:
        return nums[i] * nums[j]

proc fixExpensesPart2(nums: seq[int]): int =
  for i in 0..nums.high:
    for j in i+1..nums.high:
      for k in j+1..nums.high:
        if nums[i] + nums[j] + nums[k] == 2020:
          return nums[i] * nums[j] * nums[k]

when isMainModule:

  const s = readFile("inputs/day01.txt").strip
  let nums = stringToInts(s)

  let part1 = fixExpenses(nums)
  test "part1":
    check part1 == 988771

  let part2 = fixExpensesPart2(nums)
  test "part2":
    check part2 == 171933104