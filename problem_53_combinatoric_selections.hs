import Data.List

facs = scanl (*) 1 [1..]
fac x = facs !! x

answer = let args = [(n, r) | n <- [1..100], r <- [1..100], r <= n]
             choose (n, r) = (fac n) `div` ((fac r) * (fac (n - r)))
         in  length $ filter (1000000 <) $ map choose args

main = putStrLn $ show answer
