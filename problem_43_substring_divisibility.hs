import Data.List

hasTheProperty nStr = all (\(num, div) -> num `mod` div == 0) $ zip nums divisors
  where
    nums = map toNum [take 3 $ iterate (+1) i | i <- [1..7]]
    toNum = read . map (nStr !!)
    divisors = [2, 3, 5, 7, 11, 13, 17]

answer = sum $ map read $ filter hasTheProperty $ permutations "1234567890"

main = putStrLn $ show answer
