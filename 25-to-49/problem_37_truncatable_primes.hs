import Data.List

truncatablePrimes = let primes' = dropWhile (<10) primes
                    in  take 11 $ filter (all isPrime . truncations) primes'

truncations x = let xStr = show x
                in nub $ map read $ filter (not . null) $ init (inits xStr) ++ tail (tails xStr)

primes = 2 : 3 : (filter isPrime [5..])
isPrime 1 = False
isPrime x = let sqrtx = floor $ sqrt $ fromInteger x
            in  all ((/=0) . mod x) $ takeWhile (<=sqrtx) primes

main = putStrLn $ show $ sum truncatablePrimes
