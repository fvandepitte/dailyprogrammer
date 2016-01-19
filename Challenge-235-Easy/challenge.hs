module Challenge where

import Data.List (nub)

factor :: Integral a => a -> [a]
factor 1 = []
factor n = let divisors = dropWhile ((/= 0) . mod n) [2 .. ceiling $ sqrt $ fromIntegral n]
           in let prime = if null divisors then n else head divisors
              in (prime :) $ factor $ div n prime

isRuthAaronPair :: Integral a => (a, a) -> ((a, a), Bool)
isRuthAaronPair (a, b) = ((a, b), consecutiveNumbers a b && factorSum a == factorSum b)
    where factorSum = sum . nub . factor
          consecutiveNumbers a b = a - b == 1 || b - a == 1 

niceOutput :: Show a => ((a, a), Bool) -> String
niceOutput (a, x) = show a ++ niceOutput' x
    where niceOutput' True = " is VALID"
          niceOutput' _    = " is not VALID"

main = interact (unlines . map (niceOutput . isRuthAaronPair . read) . tail . lines) 