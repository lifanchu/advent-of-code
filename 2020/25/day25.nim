import unittest, strutils, sequtils

proc findLoopSize(publicKey: int): int = 
  var num = 1
  let subjectNum = 7
  while num != publicKey: 
    num = num * subjectNum 
    num = num mod 20201227
    result.inc
    
proc findEncryptionKey(subjectNumber: int, loopSize: int): int =
  result = 1
  for i in 0..<loopSize:
    result = result * subjectNumber
    result = result mod 20201227

when isMainModule:
  const input = staticRead("day25.txt").strip.split('\n').map(parseInt)
  
  #part one
  echo findEncryptionKey(input[1],  findLoopSize(input[0]))

  test "Loop size finding":
    check findLoopSize(5764801) == 8
    check findLoopSize(17807724) == 11
  test "encryption":
    check findEncryptionKey(5764801, 11) == 14897079 
    check findEncryptionKey(17807724, 8) == 14897079
