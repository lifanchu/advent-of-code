Things learned from other solutions:

If output is `int` then default value of `result` is `0`. No need for `result = 0`.

You do not need `readFile` before iterating over the lines. You can do:

```
for line "myfilename.txt".lines:
  echo line
```

Easier way to ask, "Is this in a range?"

```
let a = 5

if a <= 10 and a >= 0:
  echo "In range"
  
if a in 0..10:
  echo "In range"
```