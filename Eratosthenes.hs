module Eratosthenes (Sieve, getSieve, isPrime) where

import Control.Monad
import Control.Monad.ST
import qualified Data.Vector as V
import qualified Data.Vector.Mutable as VM

type Sieve = V.Vector Bool

getSieve :: Int -> Sieve
getSieve max = runST $ do
  sieve <- VM.replicate (max + 1) True
  forM_ [0, 1] (\n -> VM.write sieve n False)
  fillSieve 2 max sieve
  V.freeze sieve

fillSieve n nMax sieve =
  if n > nMax
    then 
      return ()
    else do
      isStillPrime <- VM.read sieve n
      if isStillPrime
        then do
          forM_ multiples $ \m -> VM.write sieve m False
          fillSieve (n + 1) nMax sieve
        else
          fillSieve (n + 1) nMax sieve

  where multiples = takeWhile (< nMax) [n * x | x <- [2..]]

isPrime sieve num = sieve V.! num
