module IntroMike where

x :: Integer
x = 23

y :: Integer
y = 23 + 45

-- Ein Haustier ist eins der folgenden:
-- - Hund
-- - Katze
-- - Schlange
data Pet = Dog | Cat | Snake
  deriving Show
-- ^ neuer Datentyp

-- Ist Haustier niedlich?
isCute :: Pet -> Bool
-- 3 Fälle => 3 Gleichungen
isCute Dog = True
isCute Cat = True
isCute Snake = False

-- Ein Gürteltier hat folgende Eigenschaften:
-- - lebendig oder tot
-- - Gewicht
data Liveness = Dead | Alive 
  deriving Show -- definiert Pendant zu .toString in Java automatisch

type Weight = Integer

-- Ein Tier ist eins der folgenden:
-- - Gürteltier
-- - Papagei
-- In Haskell:
-- alle Fälle von gemischten Daten müssen auf einmal definiert werden

{-
data Dillo = Dillo Liveness Weight
  deriving Show
--   ^^^ Typ
--           ^^^^^ Konstruktor
-}

-- algebraischer Datentyp
data Animal =
    Dillo { dilloLiveness :: Liveness, dilloWeight :: Weight }
  | Parrot String Weight
  deriving Show

dillo1 :: Animal
dillo1 = Dillo Alive 10 -- lebendiges Gürteltier, 10kg
dillo2 :: Animal
dillo2 = Dillo Dead 8 -- totes Gürteltier, 8kg

{-
-- Gürteltier überfahren
runOverDillo :: Dillo -> Dillo
runOverDillo (Dillo l w) = Dillo Dead w
--           ^^^^^^^^^^^ Pattern
-}

-- Tier überfahren
runOverAnimal :: Animal -> Animal
runOverAnimal dillo@(Dillo {}) = dillo { dilloLiveness = Dead }
runOverAnimal (Parrot sentence weight) = Parrot "" weight

-- Tier füttern
feedAnimal :: Weight -> (Animal -> Animal)
feedAnimal amount (Dillo Alive weight) = 
    Dillo Alive (amount + weight)
feedAnimal amount (Dillo Dead weight) = 
    Dillo Dead weight
feedAnimal amount (Parrot sentence weight) = 
    Parrot sentence (amount + weight)

feedAnimal5 :: Animal -> Animal
feedAnimal5 = feedAnimal 5

-- Eine Liste ist eins der folgenden:
-- - die leere Liste  []
-- - eine Cons-Liste aus erstem Element und Rest-Liste   first : rest
data List a = -- Typ-Parameter
    Empty
  | Cons a (List a)
  deriving Show

listSum :: [Integer] -> Integer
listSum [] = 0
listSum (first:rest) = 
    first + (listSum rest)

{-
Vorgehensweise:

1. möglichst einfache Beispiele einholen
2. einfache Beispiele in atomare Bauteile aufteilen
3. suche Selbstreferenzen

-}

{-
Finanzverträge:

Zero-Coupon Bond
"Receive 100GBP on 29 Jan 2001"
"Pay 105GBP on 1 Feb 2002"

3 Ideen:

- "später"
- "Währung"
- "Betrag"

später: "bezahlen"
-}

type Amount = Double

data Currency = EUR | GBP | YEN
  deriving Show

data Date = Date String
  deriving (Show, Eq, Ord) -- Eq: equals, Ord: Comparable

{-
data Contract =
    ZeroCouponBond Amount Currency Date
  | Call
  | Put 
  | Himalaya
  | Everest
    deriving Show
-}

data Contract =
    One Currency  -- "Ich bekomme 1EUR JETZT"
  | Multiple Amount Contract
  | Later Date Contract
  deriving Show

-- zcb1 = ZeroCouponBond 100 GBP (Date "2001-01-29")

zeroCouponBond :: Amount -> Currency -> Date -> Contract
zeroCouponBond amount currency date =
    Later date (Multiple amount (One currency))

zcb1 = -- Later (Date "2001-01-29") (Multiple 100 (One GBP))
  zeroCouponBond 100 GBP (Date "2001-01-29")

strange = Later (Date "2020-01-01")