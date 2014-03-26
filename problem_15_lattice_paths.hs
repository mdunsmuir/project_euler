import Data.Function.Memoize

numPaths :: Int -> Int
numPaths size = 1 + numPaths'' 0 0
  where numPaths' x y | any (size==) [x, y] = 0 -- if we are out of bounds, no paths here
                      | otherwise           = 1 + numPaths'' (x + 1) y + numPaths'' x (y + 1)
        numPaths'' = memoize2 numPaths'

main = putStrLn $ show $ numPaths 20
