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
-- 4. Idee: Richtung umdrehen

-- Immer suchen: Monoid 
-- - 2stellige Operation: Contract -> Contract -> Contract
-- - (Assoziativgesetz)
-- - neutrales Element


data Direction = Long | Short
 deriving Show
{-
data Contract' = Contract'' Direction Contract
-}

data Contract =
      Coin Currency -- Coin EUR "1 EUR jetzt"
    -- | Combine [Contract]
    | Combine Contract Contract
    | EmptyContract -- "neutrales Element"
    | Multiply Amount Contract
    | Later Date Contract 
    | Invert Contract -- aus in wird out und umgekehrt
    deriving Show

zeroCouponBond :: Date -> Amount -> Currency -> Contract
zeroCouponBond date amount currency = Later date (Multiply amount (Coin currency))

zcb1 :: Contract
zcb1 = zeroCouponBond "2021-12-24" 100 EUR

zcb2 :: Contract
zcb2 = zeroCouponBond "2021-12-24" 100.0 GBP

currencySwap date amountIn currencyIn amountOut currencyOut =
  Combine (zeroCouponBond date amountIn currencyIn)
          (Invert (zeroCouponBond date amountOut currencyOut))


data Payment = Payment Date Direction Amount Currency
  deriving Show

multiplyPayment factor (Payment date direction amount currency) =
  Payment date direction (amount * factor) currency

-- Semantik
payments :: Contract -> Date -> ([Payment], Contract) -- "Restvertrag", "Residualvertrag"
payments EmptyContract now = ([], EmptyContract)
payments (Coin currency) now = ([Payment now Long 1 currency], EmptyContract)
payments (Combine contract1 contract2) now = undefined 
payments (Later date contract) now = undefined 
payments (Invert contract) now = undefined 
payments (Multiply factor contract) now = 
  let (contractPayments, contractRest) = payments contract now
  in (map (multiplyPayment factor) contractPayments,
      Multiply factor contractRest)



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