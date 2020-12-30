#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Input:: *)
(*input =  Import[FileNameJoin[{NotebookDirectory[], "input.txt"}], "List"];*)


(* ::Text:: *)
(*Part One*)


(* ::Input:: *)
(*f[relation_] := Module[{parts = StringSplit[relation, ")"]},*)
(*						parts[[1]]<->parts[[2]]]*)
(*orbits = Map[f, input];*)


(* ::Input:: *)
(*Total[Map[GraphDistance[orbits, "COM", #]&, VertexList[orbits]]]*)


(* ::Text:: *)
(*Part Two*)


(* ::Input:: *)
(*GraphDistance[orbits, "YOU", "SAN"] -2 *)
