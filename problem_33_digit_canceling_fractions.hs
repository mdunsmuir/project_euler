import Data.List
import Math.NumberTheory.Primes

reducedPairProduct = (fst pair `quot` commonFactor, snd pair `quot` commonFactor)
  where pair = pairProduct
        commonFactor =  foldl1 (*) $ intersect (primeFactorsOf $ fst pair) (primeFactorsOf $ snd pair)

pairProduct = foldl1 p finalPairs
  where p x y = (fst x * fst y, snd x * snd y)

finalPairs = filter lt1gt0 (fractionPairs >>= cancelPair) >>= checkPair
  where lt1gt0 (_, pair) = fst pair < snd pair && fst pair > 0

checkPair (pair, cancelledPair) | fracValue pair == fracValue cancelledPair = [pair]
                                | otherwise                                 = []
  where fracValue pair = (fromIntegral $ fst pair) / (fromIntegral $ snd pair)

cancelPair pair | sort strNum /= sort strDen  &&
                  length common == 1          &&
                  head common /= '0'             = let delCommon = read . delete (head common)
                                                   in  [(pair, (delCommon strNum, delCommon strDen))]
                | otherwise                      = []
  where (num, den) = pair
        strNum = show num
        strDen = show den
        common = intersect strNum strDen

fractionPairs = [(x, y) | x <- numsInRange, y <- numsInRange, x < y]
  where numsInRange = [10..99]

primeFactorsOf x = fst $ factors !! lastFactor
  where 
    lastFactor = 1 + (length $ takeWhile ((/=1) . snd) factors)
    factors = scanl f ([], x) primes
    f (found, remain) fac = (m ++ found, quot remain $ foldl (*) 1 m)
      where m = replicate (multiplicity remain fac) fac

-- find the multiplicity of a prime factor f of x'
multiplicity x' f | x' `hasFactor` f = 1 + multiplicity (x' `quot` f) f
                  | otherwise        = 0

hasFactor x = (==0) . mod x
