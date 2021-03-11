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

