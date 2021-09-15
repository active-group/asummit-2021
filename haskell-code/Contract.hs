module Contract where

-- Zero-Coupon-Bond 
-- Ich bekomme Weihnachten 100 EUR.
-- Ich bekomme Weihnachten 100 GBP.

type Date = String -- "2021-12-24"
type Amount = Double
data Currency = EUR | GBP
  deriving Show

-- Funktionale Modellierung / Modellierung mit Kombinatoren
-- 1. möglichst einfache Beispiele
-- 2. in möglichst kleine Einzelteile / Ideen zerlegen

-- Alternative:
-- data Amount = Amount Double Currency

-- Zero-Coupon Bond:
-- 1. Idee: Währung festlegen / "Währung"
-- 2. Idee: Betrag
-- 3. Idee: "später"

data Contract =
    Coin Currency -- "1 EUR jetzt"
    deriving Show



{-
data Contract =
     ZeroCouponBond Date Amount Currency 
   | CurrencySwap Date Amount Currency Amount Currency
   | Everest
   | Himalaya
   -- usw. jedesmal erweitern, wenn neues Produkt
   deriving Show

{-
- Ted will Preis wissen
- Risikokontrolle will Szenarien
- Marie möchte Zahlungen
-}

zcb1 :: Contract
zcb1 = ZeroCouponBond "2021-12-24" 100 EUR

zcb2 :: Contract
zcb2 = ZeroCouponBond "2021-12-24" 100.0 GBP

swap1 = CurrencySwap "2021-12-24" 100 EUR 100 GBP

-}