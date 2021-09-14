module Intro where

x :: Integer
x = 12 * 23

-- Ein Tier auf dem texanischen Highway ist eins der folgenden:
-- - Gürteltier (lebendig/tot, Gewicht)
-- - Papagei (Satz, Gewicht)
-- gemischte Daten aus zusammengesetzte Daten
-- ---> algebraische Datentyp
data Animal =
    Dillo Bool Int 
  | Parrot String Int
  deriving Show

-- Gürteltier, lebendig, 10kg
dillo1 :: Animal
dillo1 = Dillo True 10
-- totes Gürteltier, 12kg
dillo2 :: Animal
dillo2 = Dillo False 12

parrot1 :: Animal
parrot1 = Parrot "Hallo1" 1