import Data.List
import Primes

testFactors xs = all ((==(length xs)) . length) $ map (nub . primeFactorsOf) xs
checkConsecutives groupSize = find testFactors [take groupSize $ iterate (+1) x | x <- [1..]]

main = putStrLn $ show $ checkConsecutives 4
