import unittest, sequtils, strutils, strscans, tables, re, sets

type
  Rule = seq[int]
  
# proc ruleHelper(s: string): Rule =
#   result.add parts[0].parseInt
#   try:
#     result.add parts[1].parseInt
#   except: discard

# proc toRawRule(s: string): (Rule, Rule) =
#   let parts = 
#     if '|' in s:
#       s.split('|')
#     else:
#       @[s, ""]
#   result[0] = parts[0].ruleHelper
#   result[1] = 
#     if parts[1].len > 0:
#       parts[1].ruleHelper
#     else:
#       newSeq[int]()
  
proc parseRules(rules: var Table[int, string]): string =
  var resolved: Table[int, string]

  while not resolved.hasKey(0):
    for num, rule in rules.pairs:
      if rule[0] == '"':
        resolved[num] = $rule[1]
      else:
        let parts = rule.split(' ')
        var allFound = true
        for part in parts:
          if part == "|":
            continue
          if not resolved.hasKey(part.parseInt):
            allFound = false

        if allFound:
          var r = ""
          for part in parts:
            if part == "|":
              r &= "|"
            else:
              r &= resolved[part.parseInt]
          resolved[num] = "(" & r & ")"
  result = resolved[0] 

proc solve2(rules: var Table[int, string], msgs: seq[string]): int =
  var okay = initHashSet[string]()
  var resolved: Table[int, string]
  
  rules[8] = "42 | 42 8"
  rules[11] = "42 31 | 42 11 31"
  while true:
    var added = false
    for num, rule in rules.pairs:
      if rule[0] == '"':
        resolved[num] = $rule[1]
      else:
        let parts = rule.split(' ')
        var allFound = true
        for part in parts:
          if part == "|":
            continue
          if not resolved.hasKey(part.parseInt):
            allFound = false

        if allFound:
          var r = ""
          for part in parts:
            if part == "|":
              r &= "|"
            else:
              r &= resolved[part.parseInt]
          resolved[num] = "(" & r & ")"

    if not resolved.hasKey(0):
      continue
    for msg in msgs:
      # if msg.match(re("^" & resolved[0] & "$")): 
      if msg.match(re("^" & resolved[0] "$")): 
        if not okay.contains(msg): 
          okay.incl(msg)
          added = true
    if not added:
      return okay.len

proc countMatches(pattern: string, msgs: seq[string]): int =
  let p = "^" & pattern & "$"
  for m in msgs:
    if m.match(p.re):
      result.inc

when isMainModule:
  const input = staticRead("day19.txt").strip.split("\n\n")
  var raw_rules = initTable[int, string]()
  for r in input[0].split('\n'):
    let halves = r.split(':')
    raw_rules[halves[0].strip.parseInt] = halves[1].strip

  let msgs = input[1].split('\n')
  # discard parseRules(raw_rules) #.countMatches(msgs)
  echo solve2(raw_rules, msgs)
