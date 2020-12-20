import unittest, intsets, strutils 

type
  Instruction = tuple
    op: string
    arg: int

proc implement(instructions: seq[Instruction]): (bool, int)  =
  var visited = initIntSet()
  var index = 0
  while index notin visited :
    visited.incl(index)
    case instructions[index].op:
      of "acc":
        result[1].inc instructions[index].arg   
        index.inc
      of "jmp": 
        index.inc instructions[index].arg
      of "nop":
        index.inc
    if index == instructions.len:
      result[0] = true
      break

proc detectError(instructions: seq[Instruction]): int =
  for i, line in instructions:
    var testCase = instructions
    if line.op == "jmp": 
      testCase[i].op = "nop"
    elif line.op == "nop": 
      testCase[i].op = "jmp"
    else:
      continue
    let outcome = implement(testCase)
    if outcome[0]:
      return outcome[1]

when isMainModule:
  const s = staticRead("day08.txt").strip.split('\n')
  var instructions =  newSeq[Instruction](s.len)
  for i, line in s:
    let frags = line.split(' ')
    instructions[i] = (frags[0], frags[1].parseInt)
  
  test "check part 1 examples":
    discard
  test "check part 1 solution":
    check implement(instructions)[1] == 1727
  test "check part 2 examples":
    discard
  test "check part 2 solution":
    check detectError(instructions) == 552
