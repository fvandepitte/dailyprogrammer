module Challenge where

import Data.List

testFangs :: Int -> [Int] -> Bool
testFangs a xs = (sort . show $ a) == sort (concatMap show xs) 

generateListHelper :: [Int] -> [[Int]] -> [[Int]]
generateListHelper nums fangs = [xs | a <- nums, b <- fangs, xs <- [a:b]]

generateList :: Int -> [[Int]]
generateList n = iterate (generateListHelper nums) (map (: []) nums) !! (n - 1)
    where nums = [10 .. 99]

generateFangs :: Int -> Int -> [(Int, [Int])]
generateFangs n m = filter (uncurry testFangs) $ filter (\(y, _) -> y `elem` [10 ^ (n - 1) .. 10 ^ n - 1]) $ map (\xs -> (product xs, xs)) $ generateList m

pretifiyFangs :: [(Int, [Int])] -> [String]
pretifiyFangs = map (\(y,xs) -> show y ++ " = " ++ concatMap (\x -> show x ++ "*") (init xs) ++ show (last xs))