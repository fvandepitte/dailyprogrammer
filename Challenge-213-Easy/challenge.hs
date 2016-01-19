import Data.List

main = do   
    line <- getLine
    putStrLn $ map niceOutput $ repeatRule 25 rule90 line

type Cell = (Char, Char, Char)
type Rule = Cell -> Char

rule90 :: Rule
rule90 ('1', _, '0') = '1'
rule90 ('0', _, '1') = '1'
rule90 _             = '0'

toCell :: String -> Cell
toCell (l:c:r:_) = (l, c, r)
toCell _         = ('0', '0', '0') 

parseInput :: String -> [Cell]
parseInput input =  map toCell $ filter (not.(==[])) $ tails input

applyRule :: Rule -> String -> String
applyRule rule input = map rule $ parseInput $ "0" ++ input ++ "0"

repeatRule :: Int -> Rule -> String -> String
repeatRule x rule input = unlines $ take x $ iterate (applyRule rule) input

niceOutput :: Char -> Char
niceOutput '1' = '*'
niceOutput '0' = ' '
niceOutput x   = x