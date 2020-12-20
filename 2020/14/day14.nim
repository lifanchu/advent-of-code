import unittest, strutils, tables, bitops, strscans

proc applyMask(n: int, mask: string): int =
  result = n
  for ind, c in mask:
    let i = 36 - ind - 1
    if c == '1':
      result.setBit(i)
    elif c == '0':
      result.clearBit(i)
    
proc solve1(rows: seq[(string, string)]): int =
  var mask = ""
  var table = initTable[int, int]()
  for row in rows:
    let (rule, val) = (row[0], row[1])
    if rule == "mask":
      mask = val
    else:
      var key: int
      discard rule.scanf("mem[$i]", key)
      table[key] = applyMask(parseInt(val), mask)
  for val in table.values:
    result += val
      
proc decodeAddress(n:int,  mask: string): seq[int] =
  var address = n
  for ind, c in mask:
    let i = 36 - ind - 1
    if c == '1':
      address.setBit(i)
  discard
      
proc solve2(rows: seq[(string, string)]): int =
  discard

proc parse(s: seq[string]): seq[(string, string)] =
  for row in s:
    let parts = row.split('=')
    result.add (parts[0].strip, parts[1].strip)

when isMainModule:
  const s = staticRead("day14.txt").strip.split('\n')
  let rows = parse(s)

  const example = """mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0""".strip.split('\n')
  let exRows = parse(example)
  
  test "part 1 example":
    check solve1(exRows) == 165
  test "part 2":
    check solve1(rows) == 13476250121721


