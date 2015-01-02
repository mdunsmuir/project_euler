import Control.Monad.State.Strict
import qualified Data.Map.Lazy as M

type CollatzState = State (M.Map Int Int, (Int, Int))

collatzNext x 
  | even x = x `div` 2
  | otherwise = 3 * x + 1

collatzLen x len
  | x == 1 = return $ len + 1
  | otherwise = do
      (map, _) <- get
      let maybeLen = M.lookup x map
      case maybeLen of
        Just l -> return $ len + l
        Nothing -> let next = collatzNext x
                   in  collatzLen next (len + 1)

storeSequenceFor x = do
  len <- collatzLen x 0
  (map, m@(_, curMax)) <- get
  let map' = M.insert x len map
  if len > curMax
    then put (map', (x, len))
    else put (map', m)
  
longestCollatzSequence :: Int -> CollatzState (Int, Int)
longestCollatzSequence max = do
  mapM storeSequenceFor (takeWhile (max >=) [1..])
  (_, ans) <- get
  return ans

main = putStrLn $ show $ evalState (longestCollatzSequence 999999) (M.empty, (0, 0))
