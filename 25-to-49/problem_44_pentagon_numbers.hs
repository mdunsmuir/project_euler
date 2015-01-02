import qualified Data.Set as Set

-- pnum stuff

pNumsLength = 3000
pNums = getPNumSet pNumsLength
  where
    pNum n = truncate $ n * (3 * n - 1) / 2
    getPNumSet n = Set.fromList $ take n $ map pNum [1..]

isPNum :: Int -> Bool
isPNum n = Set.member n pNums

-- pair stuff

data Pair = Pair Int Int deriving (Eq, Show)
pairSum (Pair a b) = a + b
pairDiff (Pair a b) = abs (a - b)

validPair p = let
                sum = pairSum p
                diff = pairDiff p
              in 
                sum <= Set.findMax pNums && isPNum sum && isPNum diff

instance Ord Pair where
  (<=) a b = (pairDiff a) <= (pairDiff b)

-- control stuff

test n = Set.foldr f Set.empty toTest
  where
    (toTest, _) = Set.split n pNums
    f n' diffs
      | validPair p = Set.insert p diffs
      | otherwise   = diffs
      where p = Pair n n'

testAll = Set.foldr f Set.empty pNums
  where
    f n diffs = Set.union diffs $ test n

main = do
  putStrLn $ show $ pairDiff $ Set.findMin testAll
