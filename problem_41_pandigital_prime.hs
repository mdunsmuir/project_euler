import System.Environment
import Data.List
import Primes

digits = "123456789"
isNPandigital n = (==(take n digits)) . sort . show
nPandigitalPrimes n = [p | p <- takeWhile (<(10^n)) primes, isNPandigital n p]

main = do
  args <- getArgs
  if length args /= 1
    then putStrLn "must give n"
    else putStrLn $ show $ nPandigitalPrimes $ read $ head args
