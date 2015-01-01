import Data.Numbers.Primes
import Data.List
import qualified Data.Set as S

areRelativelyPrime :: Integral a => a -> a -> Bool
areRelativelyPrime n m = 
  let primeSet = S.fromList . primeFactors
  in  S.null $ primeSet n `S.intersection` primeSet m

phi n = length $ filter (areRelativelyPrime n) $ [1..n]

answer maxN = fst $ maximumBy (\(_, a) (_, b) -> a `compare` b) pairs
  where pairs = map (\n -> (n, fromIntegral n / fromIntegral (phi n))) [1..maxN]
