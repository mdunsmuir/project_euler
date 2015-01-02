import ContinuedFractions
import Data.Digits
import Data.Ratio

sqrt2Terms = 1 : repeat 2
eTerms = 2 : eTerms' 1
  where eTerms' k = 1 : k * 2 : 1 : eTerms' (k + 1)

answer n = sum $ digits 10 $ numerator $ n `thConvergent` eTerms

main = putStrLn $ show $ answer 100
