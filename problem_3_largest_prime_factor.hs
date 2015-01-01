import Data.List

primeFactorsOf x = let 
                     toTest = takeWhile (<sqrtx) [2..]
                     sqrtx = floor $ sqrt $ fromInteger x
                   in
                     case find ((0 ==) . (x `mod`)) toTest of
                       Just factor -> factor : primeFactorsOf (x `div` factor)
                       Nothing     -> [x]

answer n = maximum $ primeFactorsOf n
