import strutils, sequtils, unittest

proc fixExpenses(n: seq[int]): (int, int) =
  for i in 0..n.high:
    for j in i+1..n.high:
      if n[i] + n[j] == 2020:
        result[0] = n[i] * n[j] 
      for k in j+1..n.high:
        if n[i] + n[j] + n[k] == 2020:
          result[1] = n[i] * n[j] * n[k]

when isMainModule:
  let nums = toSeq(lines("day01.txt")).map(parseInt)
  let solutions = fixExpenses(nums)
  test "part1":
    check solutions[0] == 988771
  test "part2":
    check solutions[1] == 171933104