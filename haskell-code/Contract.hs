module Contract where

-- Zero-Coupon-Bond 
-- Ich bekomme Weihnachten 100 EUR.
-- Ich bekomme Weihnachten 100 GBP.

type Date = String -- "2021-12-24"
type Amount = Double
data Currency = EUR | GBP

data Contract =
    ZeroCouponBond Date Amount Currency 
    deriving Show