# Advent of Code nim solutions

```
  _   _                  __  __   
 | \ |"|       ___     U|' \/ '|u 
<|  \| |>     |_"_|    \| |\/| |/ 
U| |\  |u      | |      | |  | |  
 |_| \_|     U/| |\u    |_|  |_|  
 ||   \\,-.-,_|___|_,-.<<,-,,-.   
 (_")  (_/ \_)-' '-(_/  (./  \.)  

```

This is a collection of solutions to Advent of Code exercises coded in Nim. There are solutions for multiple years.

Each year has its own directory. Each year's directory is organized in the following fashion:

- The base directory has `.nim` solution files (titled `day01.nim`, `day02.nim`, etc.)  
- The `inputs` contains the inputs I received in text files (`day01.txt`, etc.). The solution files read the input from these.

## Template for tests

```
import unittest

when isMainModule:
  test "check part 1 examples":
    discard
  test "check part 2 examples":
    discard
  test "check part 2 solution":
    discard
  test "check part 2 solution":
    discard
```