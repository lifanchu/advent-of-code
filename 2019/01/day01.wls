#!/usr/bin/env wolframscript

input = FileNameJoin[{Directory[], "input.txt"} ] // Import[#, "List"] &;

(* Part 1 *)
getMass[m_] := Floor[m / 3] - 2
Total[getMass /@ input]

(* Part 2 *)
recursiveGetMass[m_] := NestWhileList[getMass, m, # > 0 &][[2;;-2]] // Total
Total[recursiveGetMass /@ input]
