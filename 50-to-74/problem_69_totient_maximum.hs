import System.Environment
import Data.Numbers.Primes
import Data.List
import qualified Data.Set as S

uniquePrimeFactors = S.toList . S.fromList . primeFactors

phi' :: Int -> Int
phi' n = let f p = 1.0 - 1.0 / p
         in  round (fromIntegral n * product (map (f . fromIntegral) (uniquePrimeFactors n)))

answer maxN = fst $ maximumBy (\(_, a) (_, b) -> a `compare` b) pairs
  where pairs = map (\n -> (n, fromIntegral n / fromIntegral (phi' n))) [1..maxN]

main = do
  args <- getArgs
  if length args /= 1
    then putStrLn "gotta give a max n"
    else putStrLn $ show $ answer $ read $ head args
