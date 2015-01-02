import Data.List
import Primes

digitSets = [[a, b, c, d] | let rng = ['0'..'9'],
                            a <- rng, b <- rng, c <- rng, d <- rng,
                            a <= b, b <= c, c <= d]

digitPermutations = filter ((4<=) . length) $ filter (not . null) rawSets
  where rawSets = let f x = isPrime x && x >= 1000
                  in  map (nub . filter f . map read . permutations) digitSets 

validSets ps = [(a, b, c) | a <- ps, b <- ps, c <- ps,
                            a < b, b < c, b - a == c - b]

allValidSets = concat $ map validSets digitPermutations
answer = (\(a, b, c) -> show a ++ show b ++ show c) $ last allValidSets

main = putStrLn answer
