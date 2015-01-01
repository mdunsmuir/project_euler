import Text.Printf
import Data.List

main = mapM_ putStrLn [ printRow y | y <- [1..12]]
  where printRow y' = 
          concat $ intersperse " " $ map (printf "%3d" . toInteger . (y'*)) [1..12]
