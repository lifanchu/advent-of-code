#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Input:: *)
(*input =  Import[FileNameJoin[{NotebookDirectory[], "input.txt"}], "List"][[1]] // IntegerDigits;*)


(* ::Text:: *)
(*Part One*)


(* ::Input:: *)
(*layers = Partition[input, 25*6];*)
(*counts =SortBy[layers, Count[#, 0]&][[1]] // Counts;*)
(*counts[[1]] * counts[[2]]*)


(* ::Text:: *)
(*Part Two\[LongDash]a nice one-line solution that is fairly unique to Mathematica*)


(* ::Input:: *)
(*MatrixPlot[Partition[#, 25], ColorRules->{0->Black, 1->Red, 2->Transparent}]& /@ *)
(*layers // Reverse // Overlay*)
