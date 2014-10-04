import System.Environment (getArgs)
import Control.Monad (foldM)
import Data.List (sort) 
import qualified Data.Map as M (empty, findWithDefault, insert)
import Data.Digits (digits)

answer target = foldM add M.empty $ map (^3) [1..]
  where add m x = let key = sort $ digits 10 x
                      found = M.findWithDefault [] key m
                      new = x : found
                  in  if length new == target
                        then Left $ minimum new
                        else Right $ M.insert key new m

main = do
  args <- getArgs
  if length args /= 1
    then putStrLn "gotta give a target # of permutations"
    else putStrLn $ show $ answer $ read $ head args
