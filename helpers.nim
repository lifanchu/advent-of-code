import sets

proc toHashSet*[T](slice: HSlice[T, T]): HashSet[T] =
  for x in slice:
    result.incl x

proc toHashSet*[T](s: set[T]): HashSet[T] =
  for x in s:
    result.incl x
    
proc toSet*(s: string): set[char] =
  for c in s:
    result.incl c
