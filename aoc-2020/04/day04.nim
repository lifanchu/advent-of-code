import unittest, strutils, strscans, sequtils, sets

proc checkPassport(passport: string, ignoreValues: bool): bool
proc isValid(field: string, val: string): bool

proc checkPassports(passports: seq[string], ignoreValues=false): int =
  for psprt in passports:
    result.inc(psprt.checkPassport(ignoreValues).int)

proc checkPassport(passport: string, ignoreValues: bool): bool =
  let valid_fields = toHashSet(["eyr", "hcl", "hgt", "pid", "iyr", "ecl", "byr"])
  var current_fields = initHashSet[string]()
  case ignoreValues
    of false:
      for entry in passport.split(sep = ' '):
        let pair = entry.split(':')
        if isValid(pair[0], pair[1]):
          current_fields.incl(pair[0])
    of true:
      for entry in passport.split(sep = ' '):
        let key = entry.split(':')[0]
        if key != "cid":
          current_fields.incl(key)
  if current_fields == valid_fields:
    result = true

proc inRange(n:int, l: int, h:int): bool =
  n >= l and n <= h

proc isValid(field: string, val: string): bool =
  case field 
    of "byr":
      result = val.parseInt.inRange(1920, 2002) 
    of "iyr":
      result = val.parseInt.inRange(2010, 2020)
    of "eyr":
      result = val.parseInt.inRange(2020, 2030)
    of "hgt":
      var num: int
      var unit: string
      if val.scanf("$i$w", num, unit):
        if unit == "cm": 
          result = num.inRange(150, 193) 
        elif unit == "in": 
          result = num.inRange(59, 76)
    of "hcl":
      let valid = {'0'..'9','a'..'f'}.toSeq.tohashSet
      let chars = val[1..^1]
      result = val[0]=='#' and chars.len==6 and (chars.toHashSet - valid).len==0
    of "ecl":
      const colors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].toHashSet
      result = colors.contains(val)
    of "pid":
      try: 
        discard val.parseInt
        result = val.len == 9
      except ValueError: discard
    else:
      result = false

proc cleanNewLines(strings: seq[string]): seq[string] =
  result = strings
  for i in 0..strings.high:
    result[i] = result[i].replace('\n', ' ')
      
when isMainModule:
  const s = readFile("day04.txt").strip.split(sep = "\n\n").cleanNewLines
  test "examples, part 1":
    check checkPassport("ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm", true) == true
    check checkPassport("iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884 hcl:#cfa07d byr:1929", true) == false
    check checkPassport("hcl:#ae17e1 iyr:2013 eyr:2024 ecl:brn pid:760753108 byr:1931 hgt:179cm", true) == true
    check checkPassport("hcl:#cfa07d eyr:2025 pid:166559648 iyr:2011 ecl:brn hgt:59in", true) == false
  test "birth year":
    check isValid("byr", "2002") == true
    check isValid("byr", "2003") == false
  test "height":
    check isValid("hgt", "60in") == true
    check isValid("hgt", "190in") == false
  test "hair color":
    check isValid("hcl", "#123cde") == true
    check isValid("hcl", "#123cdz") == false
  test "eye color":
    check isValid("ecl", "brn") == true
    check isValid("ecl", "xxx") == false
  test "pid":
    check isValid("pid", "000000001") == true
    check isValid("ecl", "0123456789") == false
  test "part 1":
    check checkPassports(s, ignoreValues=true) == 200 
  test "Part 2":
    check checkPassports(s) == 116
