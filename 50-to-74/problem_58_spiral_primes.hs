import System.Environment
import Control.Monad
import Data.List
import qualified Data.Vector as V
import Control.Monad.Writer.Lazy
import Data.Numbers.Primes
--import Eratosthenes

data Ring = Center
          | Ring { members :: (V.Vector Int), 
                   sideLength :: Int } 
          deriving Show

rings :: [Ring]
rings = Center : rings' [3,5..] [2..]
  where
    ringLength sideLen = 4 * sideLen - 4
    rings' (sl:sls) is = let l = ringLength sl
                             (r, rs) = splitAt l is
                             rv = V.fromList r
                         in  Ring rv sl : rings' sls rs

diagonalMembers :: Ring -> [Int]
diagonalMembers Center = [1]
diagonalMembers (Ring ms sl) = snd $ runWriter $ do
                                       let di1 = sl - 2
                                           di2 = di1 + sl - 1
                                           di3 = di2 + sl - 1
                                       forM_ [di1, di2, di3] $ \di -> tell [ms V.! di]
                                       tell [V.last ms]
{-
maxPrime = 100000000
sieve = getSieve maxPrime
-}

nPrimeDiagonalMembers ring = let dms = diagonalMembers ring
                             in  length $ filter isPrime dms

primeFrac (prime, notPrime) = fromIntegral prime / fromIntegral (prime + notPrime)

primeRatios :: [(Float, Int)]
primeRatios = (0.0, 1) : (primeRatios' (0, 1) $ tail rings)
  where 
    primeRatios' (prime, notPrime) (r:rs) = let nPrimes = nPrimeDiagonalMembers r
                                                prime' = prime + nPrimes                              
                                                notPrime' = notPrime + 4 - nPrimes
                                                frac = primeFrac (prime', notPrime')
                                            in  (frac, sideLength r) : primeRatios' (prime', notPrime') rs

answer frac = find (\(f, _) -> f < frac) $ tail primeRatios

main = do
  args <- getArgs
  if length args /= 1
    then putStrLn "gotta give a fraction"
    else putStrLn $ show $ liftM snd $ answer $ read $ head args
