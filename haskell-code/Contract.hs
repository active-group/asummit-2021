module Contract where

-- Zero-Coupon-Bond 
-- Ich bekomme Weihnachten 100 EUR.
-- Ich bekomme Weihnachten 100 GBP.

type Date = String -- "2021-12-24"
type Amount = Double
data Currency = EUR | GBP
  deriving Show

data Contract =
   ZeroCouponBond Date Amount Currency 
   deriving Show

zcb1 :: Contract
zcb1 = ZeroCouponBond "2021-12-24" 100 EUR

zcb2 :: Contract
zcb2 = 