import Numeric
import Data.Char

isBinaryPalindromic n = palindromic (show n) && palindromic binStr
  where palindromic s = s == reverse s
        binStr        = showIntAtBase 2 intToDigit n ""

main = putStrLn $ show $ sum $ filter isBinaryPalindromic [1..1000000]
