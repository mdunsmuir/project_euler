module Primes where

import Data.List

primes = 2 : 3 : (filter isPrime [5..])
isPrime 1 = False
isPrime x = let sqrtx = floor $ sqrt $ fromInteger x
            in  all ((/=0) . mod x) $ takeWhile (<=sqrtx) primes

primeFactorsOf x = let 
                     primesToTest = takeWhile (<sqrtx) primes
                     sqrtx = floor $ sqrt $ fromInteger x
                   in
                     case find (\p -> x `mod` p == 0) primesToTest of
                       Just factor -> factor : primeFactorsOf (x `div` factor)
                       Nothing     -> [x]
