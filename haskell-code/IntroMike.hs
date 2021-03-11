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