import Data.List

answer = length $ filter isCircularPrime $ takeWhile (<1000000) primes
  where isCircularPrime = all isPrime . map (\s -> map digitToInt $ show s) . tail . rotations . show

-- this really isn't a standard function in Haskell?
rotations xs = take (length xs) $ iterate rotate xs
  where rotate []     = []
        rotate (x:xs) = xs ++ [x]

primes = 2 : 3 : (filter isPrime [5..])
isPrime x = let sqrtx = floor $ sqrt $ fromInteger x
            in  all (/=0) $ map (mod x) $ takeWhile (<=sqrtx) primes
        
main = putStrLn $ show answer
