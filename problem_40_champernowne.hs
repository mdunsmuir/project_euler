import Data.Char

digits = concat $ map show numbers
numbers = iterate (+1) 1
powers = map (\x -> x - 1) [1, 10, 100, 1000, 10000, 100000, 1000000]

answer :: Int
answer = foldl1 (*) $ map digitToInt $ map (digits !!) powers
