module Primes
( primes,
  isPrime,
  primeFactorsOf,
  multiplicity
) where

primes = 2 : 3 : (filter isPrime [5..])
isPrime 1 = False
isPrime x = let sqrtx = floor $ sqrt $ fromInteger x
            in  all ((/=0) . mod x) $ takeWhile (<=sqrtx) primes

primeFactorsOf x = fst $ factors !! lastFactor
  where 
    -- figure out the last prime factor
    -- then, above, we pull out the cumulative list of prime factors that
    -- is associated with it.
    lastFactor = 1 + (length $ takeWhile ((/=1) . snd) factors)

    -- we lazily generate the cumulative factors and product with a scan
    -- rather than a fold (which wouldn't work on this infinite list!)
    factors = scanl f ([], x) primes

    -- scan/fold function that returns an updated list of factors and the new
    -- remaining quantity to be factored for each potential prime factor of 
    -- multiplicity > 0
    f (found, remain) fac = (m ++ found, quot remain $ foldl (*) 1 m)
      where m = replicate (multiplicity remain fac) fac

-- find the multiplicity of a prime factor f of x'
multiplicity x' f | x' `hasFactor` f = 1 + multiplicity (x' `quot` f) f
                  | otherwise        = 0

hasFactor x = (==0) . mod x
