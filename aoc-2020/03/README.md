Things learned from other solutions:

Instead of manually entering the length of each line, use `len` (after converting to a `seq`) or `find('\n')`. Some ways you could have gotten the dimensions of the grid:

```
let maxCol = m[0].high
let maxRow = m.high

h = m.count('\n')
w = m.find('\n')
```

Other:

- Better to take movement instructions than hard code them so that you can handle new instructions in the "future"
- You can use `slurp` or `staticRead` instead of `readFile` to read at compile time