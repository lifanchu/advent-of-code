import unittest, strutils, sequtils, deques, sets

type
  Deck = Deque[int]

proc calculateScore(deck: Deck): int =
  var count = 1
  var winner = deck
  while winner.len != 0:
    result.inc winner.popLast * count
    count.inc

proc getDeckString(deck: Deck): string =
  deck.toSeq.join()
  
proc sliceDeck(deck: Deck, n: int): Deck =
  for i in 0..<n:
    result.addLast deck[i]

proc combat(playerOne: Deck, playerTwo: Deck): int =
  var p1 = playerOne
  var p2 = playerTwo
  while p1.len != 0 and p2.len != 0:
    let p1Draw = p1.popFirst()
    let p2Draw = p2.popFirst()
    if p1Draw > p2Draw:
      p1.addLast p1Draw
      p1.addLast p2Draw
    else:
      p2.addLast p2Draw
      p2.addLast p1Draw

  result = 
    if p1.len != 0: p1.calculateScore 
    else: p2.calculateScore

proc recursiveCombat(playerOne: Deck, playerTwo: Deck): (string, int) =
  var p1 = playerOne
  var p2 = playerTwo
  var p1snapshots = initHashSet[string]()
  var p2snapshots = initHashSet[string]()

  while p1.len != 0 and p2.len != 0:
    if p1snapshots.contains(p1.getDeckString) or p2snapshots.contains(p2.getDeckString):
      return ("p1", p1.calculateScore())
    p1snapshots.incl p1.getDeckString
    p2snapshots.incl p2.getDeckString

    let p1Draw = p1.popFirst()
    let p2Draw = p2.popFirst()
    
    let roundVictor =
      if p1.len >= p1Draw and p2.len >= p2Draw:
        recursiveCombat(p1.sliceDeck(p1Draw), p2.sliceDeck(p2Draw))[0]
      else:
        if p1Draw > p2Draw: "p1" else: "p2"
    
    if roundVictor == "p1": 
      p1.addLast(p1Draw)
      p1.addLast(p2Draw)
    else:
      p2.addLast(p2Draw)
      p2.addLast(p1Draw)
      
  result =
    if p1.len != 0:
      ("p1", p1.calculateScore)
    else:
      ("p2", p2.calculateScore)

when isMainModule:
  const halves = staticRead("day22.txt").strip.split("\n\n")
  let p1 = halves[0].split('\n')[1..^1].map(parseInt).toDeque
  let p2 = halves[1].split('\n')[1..^1].map(parseInt).toDeque
  
  test "p1":
    check combat(p1, p2) == 32162
  test "p2":
    check recursiveCombat(p1, p2)[1] == 32534
