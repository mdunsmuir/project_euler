import Control.Monad
import Data.List
import Data.Digits

answer = foldM f 0 [1..]
  where f s p = let c = count p
                in case c of
                     0 -> Left s
                     x -> Right $ s + x
        count p = length $ filter (p ==) $ 
                    takeWhile (p >=) [(length . digits 10) (x^p) | x <- [1..]]

main = putStrLn $ show $ answer
