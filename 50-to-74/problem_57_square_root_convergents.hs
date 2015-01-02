import Data.Ratio

ratios = map (1 +) $ iterate (\x -> 1 / (2 + x)) (1 % 2)

countRatio r = (length $ show $ numerator r) > (length $ show $ denominator r)

main = putStrLn $ show $ length $ filter id $ map countRatio $ take 1000 ratios
