import sequtils, strutils, sugar, lists, tables
import ../../helpers 

type
  Cups = seq[int]
  FastCups = SinglyLinkedRing[int]

proc removeNextThree(cups: var Cups, index: int): Cups =
  let indicesToRemove = collect(newSeq):
    for i in 1..3:
      (index + i) mod cups.len
  for i in indicesToRemove:
    result.add cups[i]
  cups = collect(newSeq):
    for i, v in cups:
      if not indicesToRemove.contains(i):
        v

proc solve(cups: Cups): int =
  var cups = cups
  var currentIndex = 0 
  
  for i in 0..<100:
    let currentCup = cups[currentIndex]
    let removedCups = cups.removeNextThree(currentIndex)
  
    var destinationCup = currentCup - 1
    
    while removedCups.contains(destinationCup) or destinationCup < 1:
      destinationCup.dec
      if destinationCup < 1:
        destinationCup = 9
    
    let destinationIndex = (cups.find(destinationCup) + 1) mod cups.len
    cups.insert(removedCups, destinationIndex)

    currentIndex = (cups.find(currentCup) + 1) mod cups.len
    
  let oneIndex = cups.find(1)
  result = block: 
    let temp = collect(newSeq):
      for i in 1..cups.high:
        $(cups[(i + oneIndex) mod cups.len])
    temp.join().parseInt


var lookup = Table[int, SinglyLinkedNode[int]]()

proc solveTwo(cups: var FastCups): int =

  var currentCup = lookup[5]

  for i in 0..<10_000_000:
      
    let removed1 = currentCup.next
    let removed2 = removed1.next
    let removed3 = removed2.next
    currentCup.next = removed3.next

    var destination = currentCup.value - 1
    while destination < 1 or
            removed1.value == destination or
            removed2.value == destination or
            removed3.value == destination:
      destination.dec
      if destination < 1:
        destination = 1_000_000

    var before = lookup[destination]
    var after = before.next
    before.next = removed1
    removed3.next = after

    currentCup = currentCup.next

  let one = lookup[1]
  result = one.next.value * one.next.next.value

when isMainModule:
  var cups = toSeq($(586439172)).map(parseInt)

  var ring = initSinglyLinkedRing[int]()
  for item in cups:
    let node = newSinglyLinkedNode[int](item)
    ring.append(node)
    lookup[node.value] = node
  for item in 10..1_000_000:
    let node = newSinglyLinkedNode[int](item)
    ring.append(node)
    lookup[node.value] = node

  echo solve(cups)
  echo solveTwo(ring)



