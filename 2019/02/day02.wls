#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Input::Initialization:: *)
rawInput =  Import[FileNameJoin[{NotebookDirectory[], "input.txt"}], "String"] // StringTrim // StringSplit[#, ","] & // ToExpression;

evaluateCode[i_] := Module[
{targ1 = input[[i + 1]] + 1,
	targ2 = input[[i + 2]] + 1,
	dest = input[[i + 3]] + 1,
	operator = If[input[[i]] == 1, Plus, Times]},
	input[[dest]] = operator[input[[targ1]], input[[targ2]]]
]



(* ::Section::Initialization:: *)
(*Part I*)


(* ::Input::Initialization:: *)
input = rawInput;
input[[2]] = 12;
input[[3]] = 2;
i = 1;
While[input[[i]] != 99,
evaluateCode[i]; i += 4];
input[[1]]



(* ::Input::Initialization:: *)



(* ::Section::Initialization:: *)
(*Part II*)


(* ::Input::Initialization:: *)
pairs = Tuples[Range[0, 99], 2] ;
For[i = 1, i <= Length[pairs], i++, 
input = rawInput;
pair = pairs[[i]];	
input[[2]] = pair[[1]];
input[[3]] = pair[[2]];
j = 1;
While[input[[j]] != 99,
evaluateCode[j]; j += 4];
If[input[[1]] == 19690720, Print[100 * pair[[1]] + pair[[2]]]; Break[]
]
]
