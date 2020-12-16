import sequtils, strutils, tables, strscans, sets, unittest, sugar

type
  Range = tuple
    bot, top: int

using
  rules: Table[string, array[2, Range]]
  tickets: seq[seq[int]]

proc rulesToRange(r: varargs[Range]): set[0..65535] =
  for rule in r:
    result = result + {rule.bot..rule.top}

proc findInvalid(rules, tickets): (int, seq[int]) =
  var valid: set[0..65535]
  for fieldName in rules.keys:
    valid = valid + rulesToRange(rules[fieldName])
  for i, t in tickets:
    for value in t:
      if not valid.contains(value):
        result[0].inc value
        result[1].add i
        
proc findValidRules(rules; values: seq[int]): HashSet[string] =
  for fieldName in rules.keys:
    result.incl fieldName
    let valid = rulesToRange(rules[fieldName])
    for val in values:
      if not valid.contains(val):
        result.excl fieldName
    
proc findFields(rules, tickets): seq[string] =
  var possible = initTable[int, HashSet[string]]()

  # iterate through cols and get possible fields
  for i in 0..tickets[0].high:
    let currentCol = block:
      var tempCol = newSeq[int](tickets.len)
      for j, t in tickets: tempCol[j] = t[i]
      tempCol
    possible[i] = findValidRules(rules, currentCol)

  result = newSeq[string](20)
  var covered: HashSet[string]
  for i in 1..possible.len:
    for index in possible.keys:
      let fields = possible[index]
      if fields.len == i:
        let unique = (fields - covered).toSeq[0]
        covered.incl unique
        result[index] = unique
        
proc solveTwo(fields: openArray[string], myTicket: seq[int]): int = 
    result = 1
    for i, field in fields:
      if field.split(' ')[0] == "departure":
        result *= myTicket[i]

proc parse(f: string): (Table[string, array[2, Range]], seq[int], seq[seq[int]]) =

  let input = readFile("day16.txt").strip.split("\n\n")

  let rules = block:
    var t = initTable[string, array[2, Range]]()
    for row in input[0].split('\n'):
      var 
        fieldName: string
        low1, high1, low2, high2: int
      if row.scanf("$*: $i-$i or $i-$i", fieldName, low1, high1, low2, high2):
        t[fieldName] = [(low1, high1), (low2, high2)]
    t

  let myTicket = input[1].split('\n')[1].split(',').map(parseInt)

  let tickets = block:
    var entries: seq[seq[int]]
    let rows = input[2].split('\n')
    for i in 1..rows.high:
      entries.add rows[i].split(',').map(parseInt)
    entries

  
  (result[0], result[1], result[2]) = (rules, myTicket, tickets)

when isMainModule:

  let (rules, myTicket, tickets) = parse("day16.txt")  
  let (solutionOne, invalidIndices) = findInvalid(rules, tickets)
    
  let validTickets = collect(newSeq):
    for i, t in tickets:
      if i notin invalidIndices: t
      
  let correctFields = findFields(rules, validTickets)

  test "part 1 solution":
    check solutionOne == 26026
  test "part 2 solution":
    check solveTwo(correctFields, myTicket) == 1305243193339

    