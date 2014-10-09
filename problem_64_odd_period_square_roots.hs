import Control.Monad
import qualified Data.Set as S

nextTriplet :: Int -> (Int, Int, Int) -> (Int, Int, Int)
nextTriplet s (m, d, a) = 
  let m' = d * a - m
      d' = (s - m'^2) `div` d
      a' = floor $ (sqrt (fromIntegral s) + fromIntegral m') / fromIntegral d'
  in  (m', d', a')

contFrac :: Int -> (Int, [Int])
contFrac s = let ((_, _, a0):ts) = contFrac' s
                 (Left cycleLen) = foldM f S.empty ts
                 f s t = let cycled = S.member t s
                         in  case cycled of
                               True -> Left $ S.size s
                               False -> Right $ S.insert t s
             in  (a0, map (\(_, _, a) -> a) $ take cycleLen ts)

contFrac' s = let m0 = 0
                  d0 = 1
                  a0 = floor $ sqrt $ fromIntegral s
              in  iterate (nextTriplet s) (m0, d0, a0)

isSquare n = sq * sq == n
  where sq = floor $ sqrt $ (fromIntegral n::Double)

nOddPeriodsUnder x = let contFracs = map contFrac $ filter (not . isSquare) $ takeWhile (<x) [2..]
                     in  length $ filter (\(_, xs) -> odd $ length xs) contFracs

main = putStrLn $ show $ nOddPeriodsUnder 10000
