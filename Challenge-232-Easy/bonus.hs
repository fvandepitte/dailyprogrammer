import Data.Char

main = do
    file <- getContents
    let fileInLines = lines file;
    print [(a,b) | a <- fileInLines, b <- fileInLines, a /= b, isPalindrome (a ++ b)]

isPalindrome :: String -> Bool
isPalindrome xs = xs == reverse xs