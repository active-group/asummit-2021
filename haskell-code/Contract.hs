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
-- 3. weitere Beispiele

-- Alternative:
-- data Amount = Amount Double Currency

-- Zero-Coupon Bond:
-- 1. Idee: Währung festlegen / "Währung"
-- 2. Idee: Betrag
-- 3. Idee: "später"

data Contract =
      Coin Currency -- Coin EUR "1 EUR jetzt"
    | Combine [Contract]
    | Multiply Amount Contract
    | Later Date Contract 
    deriving Show

zeroCouponBond :: Date -> Amount -> Currency -> Contract
zeroCouponBond date amount currency = Later date (Multiply amount (Coin currency))

zcb1 :: Contract
zcb1 = zeroCouponBond "2021-12-24" 100 EUR

zcb2 :: Contract
zcb2 = zeroCouponBond "2021-12-24" 100.0 GBP

currencySwap date amountIn currencyIn amountOut currencyOut =
  Combine [zeroCouponBond date amountIn currencyIn,
           zeroCouponBond date amountOut currencyOut]


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