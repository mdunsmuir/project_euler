import ContinuedFractions

isSquare n = sq * sq == n
  where sq = floor $ sqrt $ (fromIntegral n::Double)

nOddPeriodsUnder x = 
  let terms = map sqrtTerms $ filter (not . isSquare) $ takeWhile (<x) [2..]
  in  length $ filter (\(_, xs) -> odd $ length xs) terms

main = putStrLn $ show $ nOddPeriodsUnder 10000
