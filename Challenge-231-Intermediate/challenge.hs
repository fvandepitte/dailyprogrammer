import Data.List

main = do   
    line <- getLine
    putStrLn $ unlines $ doAll $ words line

type Card = (Char, Char, Char, Char)
type CardCheck = Card -> Card -> Card -> Bool
type Part = Card -> Char

getShape :: Part
getShape   ( s, _, _, _) = s
getColor :: Part
getColor   ( _, c, _, _) = c
getNumber :: Part
getNumber  ( _, _, n, _) = n
getShading :: Part
getShading ( _, _, _, s) = s

toCard :: String -> Card
toCard (shape:color:number:shading:_) = (shape, color, number, shading)
toCard _                              = (  ' ',   ' ',    ' ',     ' ')

tripletToCard :: (String, String, String) -> (Card, Card, Card) 
tripletToCard (a, b, c) = (toCard a, toCard b, toCard c)

toString :: Card -> String
toString (shape, color, number, shading) = [shape, color, number, shading]

allTheSame :: (Eq a) => [a] -> Bool
allTheSame (x:xs) = all (== x) xs

allDifferent :: (Eq a) => [a] -> Bool
allDifferent xs = xs == nub xs

checkCardTriplet :: Part -> CardCheck
checkCardTriplet part a b c = 
    let shapes = map part [a, b, c]
     in allTheSame shapes || allDifferent shapes

fullCheckCardTriplet :: CardCheck
fullCheckCardTriplet a b c = checkCardTriplet getShape a b c && checkCardTriplet getColor a b c && checkCardTriplet getNumber a b c && checkCardTriplet getShading a b c

fullCheckCardTriplet' :: (Card, Card, Card) -> Bool
fullCheckCardTriplet' (a, b, c) = fullCheckCardTriplet a b c

allTriplets :: [String] -> [(String, String, String)]
allTriplets xs = [ (a, b, c) | a <- xs, b <- xs, c <- xs, allDifferent [a, b, c]]

isSameTriplet :: (String, String, String) -> (String, String, String) -> Bool
isSameTriplet (a1, b1, c1) (a2, b2, c2) = 
    let second = [a2, b2, c2]
     in a1 `elem` second && b1 `elem` second && c1 `elem` second

doAll :: [String] -> [String]
doAll xs = map (\(a, b, c) -> unwords [toString a, toString b, toString c]) $ filter fullCheckCardTriplet' $ map tripletToCard $ nubBy isSameTriplet $ allTriplets xs