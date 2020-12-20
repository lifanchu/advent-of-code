import unittest, sequtils, strutils, sets, tables, hashes, strscans

type 
  Bag = object
    name: string
    capacity: Table[string, int]

proc hash(b: Bag): Hash =
  !$b.name.hash

proc readBagRule(s: string): Bag = 
  var
    name: string
    contains: string
    capacity: Table[string, int]
  if s.scanf("$* bags contain $+.", name, contains):
    for c in contains.split(','):
      var bagName: string
      var count: int 
      if c.scanf("$s$i$s$+ bag", count, bagName):
        capacity[bagName] = count
  result = Bag(name: name, capacity: capacity)

   
proc traverseUp(bag: Bag, bagTable: Table[string, Bag]): int = 
  var parents = initHashSet[Bag]() 
  for b in bagTable.values:
    if bag.name in toSeq(b.capacity.keys):
      parents.incl(b)
  while true:
    let start = parents.len
    for parent in parents:
      for b in bagTable.values:
        if parent.name in toSeq(b.capacity.keys):
          parents.incl(b)
    if parents.len == start:
      break
  result = parents.len

      
proc traverseDown(bag: Bag, bags: Table[string, Bag]): int = 
  var children: seq[(Bag, int)]
  for bagname, cap in bag.capacity.pairs:
    children.add (bags[bagname], cap)
  if children.len == 0:
    return 
  else:
    for (child, cap) in children:
      result += cap + (cap * traverseDown(child, bags))

  
when isMainModule:
     
  const s = staticRead("day07.txt").strip.split('\n')
  var bagTable: Table[string, Bag] 
  for rule in s:
    let b = rule.readBagRule
    bagTable[b.name] = b

  test "check part 1 solution":
    check traverseUp(bagTable["shiny gold"], bagTable) == 226
  test "check part 2 solution":
    check traverseDown(bagTable["shiny gold"], bagTable) == 9569
