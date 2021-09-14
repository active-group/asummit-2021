module Intro where

x :: Integer
x = 12 * 23

-- Ein Tier auf dem texanischen Highway ist eins der folgenden:
-- - Gürteltier (lebendig/tot, Gewicht)
-- - Papagei (Satz, Gewicht)
-- gemischte Daten aus zusammengesetzte Daten
-- ---> algebraische Datentyp
data Liveness = Dead | Alive
  deriving Show

-- Typ-Synonym
type Weight = Int

data Animal =
    Dillo Liveness Weight
  | Parrot String Weight
  deriving Show

-- Gürteltier, lebendig, 10kg
dillo1 :: Animal
dillo1 = Dillo Alive 10
-- totes Gürteltier, 12kg
dillo2 :: Animal
dillo2 = Dillo Dead 12

parrot1 :: Animal
parrot1 = Parrot "Hallo1" 1

-- Tier überfahren
runOverAnimal :: Animal -> Animal
-- 1 Gleichung pro Fall im Datentyp
runOverAnimal (Dillo liveness w) = Dillo Dead w
runOverAnimal (Parrot _ weight) = Parrot "" weight

-- Eine Liste ist eins der folgenden:
-- - die leere Liste
-- - eine Cons-Liste aus erstem Element und Rest-Liste
--                                               ^^^^^ Selbstbezug
data List =
    Empty
  | Cons Int List
  deriving Show

-- Liste, 1 Element, 17
list1 :: List
list1 = Cons 17 Empty
-- 2elementige Liste: 5 17
list2 :: List
list2 = Cons 5 (Cons 17 Empty)

-- Summe aller Listenelemente berechnen
listSum :: List -> Int
listSum Empty = 0
listSum (Cons first rest) = first + (listSum rest)