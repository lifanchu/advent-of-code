import unittest, strutils, sequtils
from ../../helpers import benchmark

func getCoords(): seq[tuple[row: int, col: int]] =
  for i in -1..1:
    for j in -1..1:
      if not (i==0 and j==0):
        result.add (i, j)

const coords = getCoords()

func updateSeats(seats: seq[string], nearSighted = false): seq[string]  =
  func getSurroundings(row: int, col: int): array[8, char] = 
    for i, c in coords:
      var dist = 1
      while true:
        try:
          let s = seats[row + c[0] * dist][col + c[1] * dist]
          if s == 'L' or s == '#' or nearSighted:
            result[i] = s
            break
          elif not nearSighted:
            dist.inc #increase view distance
        except: break #if view reaches edge, break
                  
  result = seats
  let cutoff = if nearSighted: 4 else: 5
  for row in 0..seats.high:
    for col in 0..seats[0].high:
      let seat = seats[row][col]
      let surroundings = getSurroundings(row, col) 
      if seat == 'L' and '#' notin surroundings:
        result[row][col] = '#'
      elif seat == '#' and surroundings.count('#') >= cutoff:
        result[row][col] = 'L'
    
    
func findEternal(seats: seq[string]): (int, int) =
  func countOccupied(chairs: seq[string]): int =
    for row in chairs:
      result.inc row.count('#')
  var pre = seats
  var nearSighted = true
  while true:
    var post = updateSeats(pre, nearSighted)
    if pre == post:
      if nearSighted: #save solution and move to part two
        result[0] = post.countOccupied
        pre = seats
        nearSighted = false
        continue
      else:
        result[1] = post.countOccupied
        break
    pre = post

when isMainModule:
    const s = staticRead("day11.txt").strip.split('\n')
      
    benchmark "":
      let solution = findEternal(s)
      test "part 1":
        check solution[0] == 2303 
      test "part 2":
        check solution[1] == 2057 
    
    
