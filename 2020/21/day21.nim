import unittest, strutils, sequtils, strscans, tables, sets, algorithm, sugar

type
  Allergen = string
  Ingredient = string

proc parseAndSolve(input: seq[string]): (int, string) =
  var allergenSources: Table[Allergen, HashSet[Ingredient]]
  var ingredientCounts = initCountTable[Ingredient]()
  for line in input:
    var left, right: string
    discard line.scanf("$* (contains $*)", left, right)
    let ingredients = left.strip.split(' ')
    let allergens = right.split(',')
    
    for ingredient in ingredients:
      ingredientCounts.inc ingredient
    
    for raw_allergen in allergens:
      let allergen = raw_allergen.strip
      let ingredientSet = ingredients.toHashSet()
      if allergenSources.hasKeyOrPut(allergen, ingredientSet):
        allergenSources[allergen] = allergenSources[allergen] * ingredientSet

  let dangerousIngredients = block:
    var temp = initHashSet[Ingredient]()
    for allergen, ingredientSet in allergenSources.pairs:
      temp = temp + ingredientSet
    temp

  # total number of inactive ingredients
  for ingredient, count in ingredientCounts.pairs:
    if ingredient notin dangerousIngredients:
      result[0].inc count 

  var associations: seq[(Ingredient, Allergen)]
  var removed = initHashSet[Allergen]()
  while true:
    for ingredient, allergenSet in allergenSources.pairs:
      if allergenSet.len == 1:
        let onlyAllergen = allergenSet.toSeq[0]
        associations.add (ingredient, onlyAllergen)
        removed.incl onlyAllergen
      allergenSources[ingredient] = allergenSources[ingredient] - removed
    if removed.len == dangerousIngredients.len:
      break

  let solutions = collect(newSeq): 
    for tup in associations.sorted():
      tup[1]
  result[1] = solutions.join(",")

when isMainModule:

  const input = staticRead("day21.txt").strip.split('\n')
  let (p1, p2) = parseAndSolve(input)

  test "p1":
    check p1 == 2569
  test "p2":
    check p2 == "vmhqr,qxfzc,khpdjv,gnrpml,xrmxxvn,rfmvh,rdfr,jxh"
