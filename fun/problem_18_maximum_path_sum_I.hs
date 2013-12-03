import System.Environment(getArgs)

main = do args <- getArgs
          if length args > 0
            then do inpstr <- readFile $ head args
                    putStrLn $ show (maxPathSum (parseData inpstr))
            else putStrLn "I need a filename with triangle data!"

parseData s = map (\s -> map read (words s)) $ lines s

maxPathSum list = 
  let addListsFold upper lower = zipWith (+) upper $ maxList lower
        where 
          maxList (x:[])   = []
          maxList (x:y:xs) = (max x y) : (maxList $ y:xs)

  in head $ foldr1 addListsFold list
