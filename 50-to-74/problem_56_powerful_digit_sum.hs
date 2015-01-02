import Data.Char

answer = maximum $ map (sum . (map digitToInt) . show) [a^b | a <- [1..100], b <- [1..100]]
