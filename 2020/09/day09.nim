import unittest, strutils, sequtils

proc checkSums(pre: openArray[int], num: int): bool = 
  for i in 0..pre.high:
    for j in i+1..pre.high:
      if pre[i] + pre[j] == num:
        return true

proc findPartOne(nums: openArray[int]): int =
  for i in 25..nums.high:
    if not checkSums(nums[i - 25..i - 1], nums[i]):
      return nums[i]

proc findPartTwo(nums: openArray[int], target: int): int =
  for i in 0..nums.high - 1:
    var cumsum = nums[i]
    for j in i+1..nums.high:
      cumsum += nums[j]
      if cumsum == target:
        return nums[i] + nums[j] 
  
when isMainModule:
  const s = staticRead("day09.txt").strip.split('\n').map(parseInt)

  test "check part 1 solution":
    check findPartOne(s) == 20874512
  test "check part 2 solution":
    check findPartTwo(s, 20874512) == 3012420
