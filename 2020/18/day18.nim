import unittest, strutils, deques
import ../../helpers

proc evaluateRPN(q: var Deque): int =
  var numStack: seq[int]
  while q.len > 0:
    let token = q.popFirst
    if token.isDigit: 
      numStack.add(token.parseInt)
    else: 
      case token:
        of '*': numStack.add(numStack.pop * numStack.pop)
        of '+': numStack.add(numStack.pop + numStack.pop)
        else: raise newException(ValueError, "Invalid RPN input")
  result = numStack[0]

proc shuntingYard(equation: string, partTwo = false): int =
  var q = initDeque[char]()
  var opStack: seq[char]

  for token in equation:
    if token.isDigit:
      q.addLast token
    elif token == '(': 
      opStack.add token
    elif token == ')':
      while opStack[^1] != '(': 
        q.addLast(opStack.pop)
      discard opStack.pop 
    elif token == '*' or token == '+':
      while opStack.len > 0 and opStack[^1] != '(':
        if partTwo and token == '+' and opStack[^1] == '*': 
          break 
        q.addLast(opStack.pop)
      opStack.add token

  while opStack.len > 0:
    q.addLast(opStack.pop)

  result = evaluateRPN(q)

proc solve(input: seq[string]): (int, int) =
  for line in input:
    result[0] += shuntingYard(line)
    result[1] += shuntingYard(line, true)

when isMainModule:
  const input = staticRead("day18.txt").strip.split('\n')

  let (p1, p2) = solve(input,)
  test "aoc solutions":
    check p1 == 3159145843816
    check p2 == 55699621957369
  