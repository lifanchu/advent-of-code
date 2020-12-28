#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Input::Initialization:: *)
nums = IntegerDigits /@ Range[240920, 789857];
filter[n_] := OrderedQ[n] && Max[Values[Counts[n]]] > 1
Select[nums, filter]//Length
filterTwo[n_] := OrderedQ[n] && MemberQ[Values[Counts[n]], 2]
Select[nums, filterTwo] //Length



