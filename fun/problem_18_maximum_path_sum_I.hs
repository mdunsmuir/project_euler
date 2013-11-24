main = do inpstr <- readFile "triangledata.txt"
          putStrLn $ show (maxPathSum (parseData inpstr))

parseData s = map (\s -> map read (words s)) $ lines s

maxPathSum list = 
  let addListsFold upper lower = zipWith (+) upper reducedLower
        where 
          reducedLower = maxList lower
          maxList (x:[])   = [x]
          maxList (x:y:xs) = (max x y) : (maxList $ y:xs)

  in head $ foldr1 addListsFold list
