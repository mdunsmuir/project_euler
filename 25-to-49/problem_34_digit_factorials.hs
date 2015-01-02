-- 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
-- Find the sum of all numbers which are equal to the sum of the factorial of their digits.

-- upper bound 25401060

answer = sum $ filter (\n -> n == (foldl1 (+) $ digitFactorials n)) [3..99999]

digitFactorials :: Int -> [Int]
digitFactorials = map (factorial . read) . map (:[]) . show

factorial n = product [1..n]
