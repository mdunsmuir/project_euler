module Primes where

primes = 2 : 3 : (filter isPrime [5..])
isPrime 1 = False
isPrime x = let sqrtx = floor $ sqrt $ fromInteger x
            in  all ((/=0) . mod x) $ takeWhile (<=sqrtx) primes
