import Data.List
import Primes

satisfies n = any isPrime $ takeWhile (>0) [n - 2 * x^2 | x <- [1..]]
answer = find (not . satisfies) [a | a <- [3, 5..], not $ isPrime a]

main = putStrLn $ show answer
