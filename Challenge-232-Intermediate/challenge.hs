import Data.List
import Data.Ord

main = do
    content <- getContents
    print $ minimumBy (comparing distance) $ createSets $ parsePoints content

type Point = (Double, Double)

parsePoints :: String -> [Point]
parsePoints = map read . tail . lines

createSets :: [Point] -> [(Point, Point)]
createSets allPoints = [(a, b) | (a:as) <- tails allPoints, b <- as]

distance :: (Point, Point) -> Double
distance ((ax, ay), (bx, by)) = sqrt $ (ax - bx) ^ 2 + (ay - by) ^ 2