Things learned from other solutions.

Aside from `map`, you can use `collect` to get something like list compreshensions.

```
import sugar
let k = collect(newSeq):
  for i in 0..10:
    if i mod 2 == 0: i
echo k
# @[0, 2, 4, 6, 8, 10]
```
