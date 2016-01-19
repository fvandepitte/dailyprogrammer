import Data.Char
main = do
        text <- getContents
        putStrLn $ niceString $ isPallindrome $ map toLower $ filter isAlpha text


isPallindrome :: Eq a => [a] -> Bool
isPallindrome xs = xs == reverse xs

niceString :: Bool -> String
niceString True = "Palindrome"
niceString _    = "Not a palindrome"