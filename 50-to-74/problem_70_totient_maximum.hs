import System.Environment
import Data.List
import qualified Data.Set as S
import Data.Maybe
import Data.Numbers.Primes
import Data.Digits

uniquePrimeFactors = S.toList . S.fromList . primeFactors

phi :: Int -> Int
phi n = let f p = 1.0 - 1.0 / p
        in  round (fromIntegral n * product (map (f . fromIntegral) (uniquePrimeFactors n)))

perm :: Int -> Int -> Maybe Int
perm n p
  | digSet n == digSet p = Just n
  | otherwise = Nothing
  where digSet = sort . digits 10

ratio :: Int -> Maybe (Int, Float)
ratio n' = do
  let p = phi n'
  n <- perm n' p
  return $ (n, fromIntegral n / fromIntegral p)

answer n = fmap (minimumBy cmp) $ sequence $ filter isJust $ map ratio [2..n]
  where cmp (_, a) (_, b) = a `compare` b

main = do
  args <- getArgs
  if length args /= 1
    then putStrLn "gotta give a max n"
    else putStrLn $ show $ answer $ read $ head args
