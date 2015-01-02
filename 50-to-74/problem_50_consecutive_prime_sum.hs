import Data.List
import Primes

-- (numTerms, prime)
consSumPrimes max terms = if null indices
                            then []
                            else let index = last indices
                                 in  [(index + 1, sums !! index)]
  where
    sums = takeWhile (<max) $ cumSum terms 0
    indices = findIndices isPrime sums

    cumSum (x:xs) sum = let newSum = sum + x 
                        in  newSum : cumSum xs newSum
    cumSum [] _ = []

loop max = concat $ map (consSumPrimes max) $ tails $ takeWhile (<max) primes
main = putStrLn $ show $ (snd . last . sort . loop) 1000000
