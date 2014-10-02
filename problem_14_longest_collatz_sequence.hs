import Control.Monad.State.Strict
import qualified Data.Map.Lazy as M

type CollatzState = State (M.Map Int [Int], (Int, Int))

collatzNext :: Int -> Int
collatzNext x 
  | even x = x `div` 2
  | otherwise = 3 * x + 1

collatz :: Int -> CollatzState [Int]
collatz x
  | x == 1 = return [1]
  | otherwise = do
      (map, _) <- get
      let maybeSeq = M.lookup x map
      case maybeSeq of
        Just s -> return s
        Nothing -> do
          let next = collatzNext x
          rest <- collatz next          
          return $ x : rest

storeSequenceFor :: Int -> CollatzState ()
storeSequenceFor x = do
  sequence <- collatz x
  (map, m@(_, curMax)) <- get
  let map' = M.insert x sequence map
      len = length sequence
  if len > curMax
    then put (map', (x, len))
    else put (map', m)
  
longestCollatzSequence :: Int -> CollatzState (Int, Int)
longestCollatzSequence max = do
  mapM storeSequenceFor (takeWhile (max >=) [1..])
  (_, ans) <- get
  return ans

main = putStrLn $ show $ evalState (longestCollatzSequence 999999) (M.empty, (0, 0))
