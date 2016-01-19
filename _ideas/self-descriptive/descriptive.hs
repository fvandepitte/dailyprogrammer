import Data.List
import Data.Char

ps :: [[[Int]]]
ps = [] : map parts [1..]
    where parts n = [n] : [x : p | x <- [1..n], p <- ps !! (n - x), x <= head p]

partitionsFor :: Int -> [[Int]]
partitionsFor = tail . (ps !!)

fillOrEmptyPartionToLength :: Int -> [Int] -> [Int]
fillOrEmptyPartionToLength x ys =
    let needed = (x - length ys)
     in fillOrEmptyPartionToLength' needed x ys
        where fillOrEmptyPartionToLength' n x ys | n `elem` ys =  ys ++ (take n $ repeat 0)
                                                 | otherwise   = []

filledPartitionsFor ::  Int -> [[Int]]
filledPartitionsFor x = filter (/= []) $ map (fillOrEmptyPartionToLength x) $ map (reverse . sort) $ partitionsFor x

retrieveInt :: [Int] -> Int
retrieveInt = read . concatMap show

count :: [Int] -> Int -> Int
count xs y = length $ filter (== y) xs

isSelfDescriptive :: Int -> Bool
isSelfDescriptive x = x == (numberDescription x)

numberDescription :: Int -> Int
numberDescription x =
    let xs = map digitToInt $ show x
     in retrieveInt $ map (count xs) [0 .. (length xs) - 1]

toOutput :: [Int] -> String
toOutput [] = "No self-descrisive number found.\n"
toOutput xs = unlines $ map show xs

main = interact (toOutput . filter isSelfDescriptive . map (numberDescription . retrieveInt) . filledPartitionsFor . read)