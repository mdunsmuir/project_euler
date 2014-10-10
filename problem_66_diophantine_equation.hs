import Data.Ratio
import Data.List
import ContinuedFractions

convergents n = 
  let terms = expandTerms $ sqrtTerms n
      expandTerms (a0, as) = a0 : cycle as
  in  map ((\r -> (numerator r, denominator r)) . convergentForTerms) $ 
        tail $ inits terms

isSolution n (x, y)
  | x^2 - n * y^2 == 1 = True
  | otherwise = False

solutions = zip (map ((\(Just (x, _)) -> x) . findSolution) dValues) dValues
  where findSolution n = find (isSolution n) $ convergents n
        dValues = filter (not . isSquare) [2..1000]
          where isSquare n = 
                  let sq = floor $ sqrt $ (fromIntegral n::Double)
                  in  sq * sq == n

main = putStrLn $ show $ snd $ maximum solutions
