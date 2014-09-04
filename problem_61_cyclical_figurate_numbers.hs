import Data.List
import qualified Data.Map.Lazy as M
import qualified Data.Set as S
import Data.Digits

intMap = takeWhile digitTest . dropWhile (not . digitTest) . (flip map) [1..]
  where digitTest = (4 ==) . length . digits 10

triNums = intMap $ \n -> n * (n + 1) `div` 2
squaNums = intMap $ \n -> n^2
pentNums = intMap $ \n -> n * (3 * n - 1) `div` 2
hexNums = intMap $ \n -> n * (2 * n - 1)
heptNums = intMap $ \n -> n * (5 * n - 3) `div` 2
octNums = intMap $ \n -> n * (3 * n - 2)

--allNums :: S.Set Int
allNums = foldl1' S.union $ map S.fromList [triNums, squaNums, pentNums, hexNums, heptNums, octNums]

--getCycleMap :: M.Map (Int, Int) (S.Set Int)
getCycleMap = S.fold f M.empty allNums
  where
    f n m = let (a:b:_) = take 2 $ digits 10 n
                ns = M.findWithDefault (S.empty) (a, b) m
                ns' = S.insert n ns
            in  M.insert (a, b) ns' m

cycles ds@(a, b) origDigits m = do
  n <- S.toList $ M.findWithDefault S.empty ds m
  let (a':b':[]) = drop 2 $ digits 10 n
  if (a', b') == origDigits
    then [n]
    else n : cycles (a', b') origDigits m
