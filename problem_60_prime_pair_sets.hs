import Data.List
import Control.Monad
import Data.Digits
import qualified Data.Map.Lazy as M
import qualified Data.Set as S
import Data.Numbers.Primes

type Pair = (Int, Int)
type PairMap = M.Map Int (S.Set Int)

pairConcats :: Pair -> Bool

pairConcats (a, b) = let perms = permutations [digits 10 a, digits 10 b]
                     in  all (isPrime . (unDigits 10) . concat) perms


pMax = 10000
primesUpToMax = takeWhile (<= pMax) primes

pairs :: [Pair]
pairs = do
  a <- primesUpToMax
  b <- dropWhile (<= a) primesUpToMax
  guard $ pairConcats (a, b)
  return (a, b)

pairSearch :: PairMap -> [Pair] -> Int -> [[Int]]
pairSearch _ [] _     = []
pairSearch m (p:ps) n = let m' = addPair p m
                            result = tryPair p m' n
                        in  case result of
                              Just xs -> xs : pairSearch m' ps n
                              Nothing -> pairSearch m' ps n

tryPair :: Pair -> PairMap -> Int -> Maybe [Int]
tryPair p@(a, b) m n = let aps = M.findWithDefault S.empty a m
                           ps  = S.intersection aps $ M.findWithDefault S.empty b m
                           exp = expandPairSet ps m
                       in  if S.size exp == n then Just (S.toList exp) else Nothing

expandPairSet s m = foldl1' S.intersection $ S.toList $ S.map (\x -> M.findWithDefault S.empty x m) s

addPair :: Pair -> PairMap -> PairMap
addPair p@(a, b) m = foldr addValue m [(a, b), (b, a)]
  where addValue (x, y) m = let ys = M.findWithDefault (S.singleton x) x m
                                ys' = S.insert y ys
                            in  M.insert x ys' m

answer n = let m = M.empty
           in  pairSearch m pairs n

main = putStrLn $ show $ minimum $ map sum $ answer 5
