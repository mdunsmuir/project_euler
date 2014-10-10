module ContinuedFractions (sqrtTerms, convergentForTerms, thConvergent) where

import Control.Monad
import qualified Data.Set as S
import Data.Ratio

-- generation of 'terms' in a continued fraction expansion of a square root

sqrtTerms :: Integral a => a -> (a, [a])
sqrtTerms s = let ((_, _, a0):ts) = sqrtTerms' s
                  (Left cycleLen) = foldM f S.empty ts
                  f s t = let cycled = S.member t s
                          in  case cycled of
                                True -> Left $ S.size s
                                False -> Right $ S.insert t s
              in  (a0, map (\(_, _, a) -> a) $ take cycleLen ts)
  where
    sqrtTerms' s = let m0 = 0
                       d0 = 1
                       a0 = floor $ sqrt $ fromIntegral s
                   in  iterate (nextTriplet s) (m0, d0, a0)

    nextTriplet s (m, d, a) = 
      let m' = d * a - m
          d' = (s - m'^2) `div` d
          a' = floor $ (sqrt (fromIntegral s) + fromIntegral m') / fromIntegral d'
      in  (m', d', a')

-- calculation of convergents given a sequence of continued fraction 'terms'

convergentForTerms :: [Integer] -> Rational
convergentForTerms [a0] = a0 % 1
convergentForTerms (a0:as) = (a0 % 1) + convergentValue as
  where convergentValue [a] = 1 % a
        convergentValue (a:as) = 1 / ((a % 1) + convergentValue as)

thConvergent n fracTerms = convergentForTerms $ take n fracTerms
