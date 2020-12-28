#!/usr/bin/env wolframscript
(* ::Package:: *)

(* ::Input::Initialization:: *)
input = StringSplit[#, ","] & /@  Import[FileNameJoin[{NotebookDirectory[], "input.txt"}], "List"] ;


(* ::Section::Initialization:: *)
(*Part I*)


(* ::Text::Initialization:: *)
(*Part one can be solved in a way that is fairly unique to Mathematica.*)


(* ::Input::Initialization:: *)
travel[{x_, y_},rule_String] := Module[{
dir = StringTake[rule, 1],
val = ToExpression[StringDrop[rule, 1]]},
Which[
dir == "L",{x - val, y},
dir == "R",{x +val, y},
dir == "U", {x, y+val},
dir == "D",{x, y - val}
] 
]


(* ::Input::Initialization:: *)
path1 = FoldList[travel, {0, 0}, input[[1]]];
path2 = FoldList[travel, {0, 0}, input[[2]]];


(* ::Input::Initialization:: *)
(* Optional: Cheat by visualizing *)
ListLinePlot[{path1, path2}]


(* ::Input::Initialization:: *)
intersections = RegionIntersection[Line[path1] , Line[path2]][[1]];
Sort[intersections,  ManhattanDistance[{0,0},#1]<ManhattanDistance[{0,0},#2]&][[2]]


(* ::Subsubsection::Initialization:: *)
(*Part II*)


(* ::Input::Initialization:: *)
getIntersectionOrMissing[{{x1_,y1_},{x2_,y2_}}, intersections_List] := 
Which[
x1 == x2, Select[intersections, #[[1]] == x1 && Min[y1, y2]<=#[[2]] <= Max[y1, y2 ]&],
y1 == y2,Select[intersections, #[[2]] == y1 && Min[x1, x2]<=#[[1]] <= Max[x1, x2]&]
]
findSteps[path_, intersections_] := Module[
{segments = Partition[path, 2, 1],
timeCrossed = <||>,
traveled =0},
Do[
seg = segments[[i]];
intersectList = getIntersectionOrMissing[seg, intersections] ;
intersectList = Select[intersectList, !KeyExistsQ[timeCrossed, #]&]; (*Only use closest crossing distance*)
If [!MissingQ[intersectList], 
Map[AssociateTo[timeCrossed, #->traveled + ManhattanDistance[seg[[1]], #]]&, intersectList], 
"" ];
traveled += ManhattanDistance[seg[[1]], seg[[2]]];, 
{i, Length[segments]}];
Return[timeCrossed]
]


(* ::Input::Initialization:: *)
counts =Merge[{findSteps[path1, intersections],findSteps[path2, intersections]}, Total];  
Values[Sort[counts]][[2]]
