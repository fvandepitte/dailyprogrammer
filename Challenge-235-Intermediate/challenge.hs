module Challenge where
import Data.Char (isDigit, digitToInt)
import Data.List (tails)

data Throw = Strike | Spare | Value Int deriving (Show, Eq)

type Round = (Throw, Throw, Throw)

parseThrow :: Char -> Throw
parseThrow '/' = Spare
parseThrow 'X' = Strike
parseThrow a | isDigit a = Value $ digitToInt a
             | otherwise = Value 0

parseRound :: String -> Round
parseRound "X"        = (Strike, Value 0, Value 0)
parseRound [a, b]     = (parseThrow a, parseThrow b, Value 0)
parseRound [a, b, c]  = (parseThrow a, parseThrow b, parseThrow c)
parseRound _          = (Value 0, Value 0, Value 0)

valueOfThrow :: Throw -> Int
valueOfThrow Strike    = 10
valueOfThrow Spare     = 10
valueOfThrow (Value a) = a

fstThrow :: Round -> Throw
fstThrow ( a, _, _) = a

sndThrow :: Round -> Throw
sndThrow ( _, a, _) = a

valueOfRound :: [Round] -> Int
valueOfRound [x] = valueOfLastRound x
    where valueOfLastRound (  Strike,  Strike,  Strike) = 60
          valueOfLastRound (       _,   Spare,  Strike) = 30
          valueOfLastRound (       _,   Spare, Value a) = 10 + a * 2
          valueOfLastRound (  Strike, Value a, Value b) = 10 + a * 2 + b * 2
          valueOfLastRound (  Strike,       _,   Spare) = 30
          valueOfLastRound ( Value a, Value b,       _) = a + b

valueOfRound (x:xs) | fstThrow x == Strike = 10 + valueOfRound  xs
                    | sndThrow x == Spare  = 10 + valueOfRound' xs
                    | otherwise             = valueOfThrow (fstThrow x) + valueOfThrow (sndThrow x)
    where valueOfRound' [x]                           = valueOfThrow (fstThrow x)
          valueOfRound' (x:xs) | fstThrow x == Strike = valueOfRound (x:xs)
                               | otherwise            = valueOfThrow (fstThrow x)
valueOfRound _ = 0

main = do
    line <- getLine
    putStrLn $ show $ sum $ map valueOfRound $ tails $ map parseRound $ words line  