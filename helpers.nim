import sets, times, os, strutils

proc toHashSet*[T](slice: HSlice[T, T]): HashSet[T] =
  for x in slice:
    result.incl x

proc toHashSet*[T](s: set[T]): HashSet[T] =
  for x in s:
    result.incl x
    
proc toSet*(s: string): set[char] =
  for c in s:
    result.incl c

template benchmark*(benchmarkName: string, code: untyped) =
  block:
    let t0 = epochTime()
    code
    let elapsed = epochTime() - t0
    let elapsedStr = elapsed.formatFloat(format = ffDecimal, precision = 3)
    echo "CPU Time [", benchmarkName, "] ", elapsedStr, "s"


proc parseInt*(c: char): int = 
  return ord(c) - ord('0')
