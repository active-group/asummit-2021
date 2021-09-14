module Intro where

import Prelude hiding (Semigroup, Monoid, Functor)

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

data Animal weight =
    Dillo Liveness weight
  | Parrot String weight
  deriving Show

-- Gürteltier, lebendig, 10kg
dillo1 :: Animal Int
dillo1 = Dillo Alive 10
-- totes Gürteltier, 12kg
dillo2 :: Animal Int
dillo2 = Dillo Dead 12

parrot1 :: Animal Int
parrot1 = Parrot "Hallo1" 1

-- Tier überfahren
-- runOverAnimal :: Animal -> Animal
-- 1 Gleichung pro Fall im Datentyp
runOverAnimal (Dillo liveness w) = Dillo Dead w
runOverAnimal (Parrot _ weight) = Parrot "" weight

-- feedAnimal :: Weight -> Animal -> Animal
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


listMap :: (a -> b) -> [a] -> [b]
listMap f [] = []
listMap f (first:rest) = (f first) : (listMap f rest)

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

instance (Semigroup a, Semigroup b) => Semigroup (a, b) where
    op (a1, b1) (a2, b2) = (op a1 a2, op b1 b2)

class Semigroup a => Monoid a where
    neutral :: a

instance Monoid [a] where
    neutral = []

instance (Monoid a, Monoid b) => Monoid (a, b) where
    neutral = (neutral, neutral)

data Additive = Additive Int
  deriving Show

instance Semigroup Additive where
    op (Additive n1) (Additive n2) = Additive (n1 + n2)

-- eingebaut: Maybe

data Optional a =
     Some a
   | None
   deriving Show

-- "Optional macht aus einer Halbgruppe einen Monoid"
instance Semigroup a => Semigroup (Optional a) where
    op None None = None 
    op None (Some x) = Some x 
    op (Some x) None = Some x 
    op (Some x) (Some y) = Some (op x y)

instance Semigroup a => Monoid (Optional a) where
    neutral = None

optionalMap :: (a -> b) -> Optional a -> Optional b
optionalMap f (Some x) = Some (f x)
optionalMap f None = None

inc x = x + 1

-- Index eines Elements berechnen
-- Eq: eingebaute Typklasse, "vergleichbar"
indexOf :: Eq a => a -> [a] -> Optional Int
indexOf x [] = None
indexOf x (first:rest) = 
    if x == first
    then Some 0
    else 
        optionalMap inc (indexOf x rest)

--        case indexOf x rest of
--            None -> None
--            Some i -> Some (i + 1)

-- f ist ein Typkonstruktor
class Functor f where
    umap :: (a -> b) -> f a -> f b

instance Functor [] where
    umap = listMap

instance Functor Optional where
    umap = optionalMap

-- Buch zu Haskell:
-- https://www.cs.nott.ac.uk/~pszgmh/pih.html
-- auch Videoreihe(n):
-- https://www.youtube.com/c/GrahamHuttonNotts/playlists