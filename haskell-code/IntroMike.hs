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
3. suche Selbstreferenzen ("closure of operations")
4. weitere Beispiele einarbeiten
5. suche >=1 binären Operator
6. Wenn Du einen binären Operator hast, finde einen Monoiden, d.h.
   Assoziativität, neutrales Element
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
data Direction = Long | Short 
  deriving Show

data Contract =
    One Currency  -- "Ich bekomme 1EUR JETZT"
  | Multiple Amount Contract
  | Later Date Contract
  | Pay Contract -- dreht alle Zahlungsströme um
  | And Contract Contract
  | Zero
  deriving Show

-- zcb1 = ZeroCouponBond 100 GBP (Date "2001-01-29")

zeroCouponBond :: Amount -> Currency -> Date -> Contract
zeroCouponBond amount currency date =
    Later date (Multiple amount (One currency))

zcb1 = -- Later (Date "2001-01-29") (Multiple 100 (One GBP))
  zeroCouponBond 100 GBP (Date "2001-01-29")

strange :: Contract
strange = Later (Date "2022-01-01") (Later (Date "2021-06-01") (One EUR))

zcb2 = Pay (zeroCouponBond 105 GBP (Date "2002-02-1"))

mortgage = And zcb1 zcb2 -- zcb1 `And` zcb2

zcb3 = Pay zcb2

a1 :: Contract
a1 = And (One GBP) (And (One EUR) (One YEN))
a2 :: Contract
a2 = And (And (One GBP) (One EUR)) (One YEN)

-- 1 Zahlung
data Payment = Payment Direction Date Amount Currency
  deriving Show

invertPayment :: Payment -> Payment
invertPayment (Payment Long date amount currency) = Payment Short date amount currency
invertPayment (Payment Short date amount currency) = Payment Long date amount currency

invertPayments :: [Payment] -> [Payment]
invertPayments [] = []
invertPayments (first:rest) = (invertPayment first) : (invertPayments rest)

scalePayment :: Amount -> Payment -> Payment
scalePayment amount' (Payment direction date amount currency) =
    Payment direction date (amount' * amount) currency

-- Banker: "Vertrag abgeschlossen"

-- alle Zahlungen bis zu einem Zeitpunkt berechnen
contractPayments :: Contract -> Date -> ([Payment], Contract)
contractPayments Zero now = 
    ([], Zero)
contractPayments (One currency) now = 
    ([Payment Long now 1 currency], Zero)
contractPayments (Multiple amount contract) now =
    let (payments, residualContract) = contractPayments contract now
    in (map (scalePayment amount) payments, Multiple amount residualContract)
contractPayments (Pay contract) now =
    let (payments, residualContract) = contractPayments contract now
    in (map invertPayment payments, Pay residualContract)
contractPayments (Later date contract) now = 
    if now < date
    then ([], Later date contract)
    else contractPayments contract now
contractPayments (And contract1 contract2) now =
    let (payments1, residualContract1) = contractPayments contract1 now
        (payments2, residualContract2) = contractPayments contract2 now
    in (payments1 ++ payments2, And residualContract1 residualContract2)



{-
Monoiden etc.

Menge M / Typ M
Funktion/Operator
op :: M -> M -> M
(Beispiele: +, *, overlay, beside, above)

Assoziativgesetz
(a + b) + c = a + (b + c)
=> legitim a + b + c

M + binärer Operator + Assoziativität: Halbgruppe

Halbgruppe + neutrales Element: Monoid

neutrales Element n:

n + x = x = x + n


-}