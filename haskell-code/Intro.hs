module Intro where

import Prelude hiding (Semigroup, Monoid)

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

feedAnimal :: Weight -> Animal -> Animal
feedAnimal amount (Dillo liveness weight) = Dillo liveness (weight + amount)
feedAnimal amount (Parrot sentence weight) = Parrot sentence (weight + amount)

-- Eine Liste ist eins der folgenden:
-- - die leere Liste
-- - eine Cons-Liste aus erstem Element und Rest-Liste
--                                               ^^^^^ Selbstbezug
-- Faustregel: Großbuchbuchstabe = Konstante, Kleinbuchstabe = Variable
data List element =
    Empty
  | Cons element (List element)
  deriving Show

-- Liste, 1 Element, 17
list1Old :: List Int
list1Old = Cons 17 Empty
-- 2elementige Liste: 5 17
list2Old :: List Int
list2Old = Cons 5 (Cons 17 Empty)

list3Old :: List Animal
list3Old = Cons dillo1 (Cons dillo2 (Cons parrot1 Empty))

-- Summe aller Listenelemente berechnen
listSumOld :: List Int -> Int
listSumOld Empty = 0
listSumOld (Cons first rest) = first + (listSumOld rest)

-- Eingebaut:
-- Empty --> []
-- Cons first rest -> first : rest
listSum :: [Int] -> Int -- "Liste von Int"
listSum [] = 0 -- neutrales Element der Addition
listSum (first:rest) = first + (listSum rest)
-- für alle x: 0 + x = x + 0 = x
 

listProduct :: [Int] -> Int
listProduct [] = 1 -- neutrales Element der Multiplikation
listProduct (first:rest) = first * (listProduct rest)
-- für alle x: 1 * x = x * 1 = x

-- Typ/Menge A
-- (: op (A A -> A)), Beispiele: +, *, overlay, beside, above
-- op :: A -> A -> A
-- Gleichungen
-- Assoziativgesetz
-- Beispiel für +: a + (b + c) = (a + b) + c
--                 a * (b * c) = (a * b) * c
-- NICHT:          a - (b - c) = (a - b) - c
-- Halbgruppe

-- Beispiele:
-- Menge: Int, Operation +
-- Menge: Int, Operation *
-- Menge: image, Operation: overlay
-- Menge [a], Operation: append, neutrales Element: []
append :: [a] -> [a] -> [a]
append [] list2 = list2
append (first:rest) list2 = first : (append rest list2)

-- Kommutativgesetzt:
-- a + b == b + a

-- Halbgruppe + neutrales Element = Monoid

-- class in Haskell: Typklasse, keine OO-Klasse
-- eher: Interface
class Semigroup a where
    -- op muß das Assoziativgesetz erfüllen
    -- op (op a b) c == op a (op b c)
    op :: a -> a -> a

-- Implementierung einer Typklasse
instance Semigroup [a] where
    op = append

class Semigroup a => Monoid a where
    neutral :: a
