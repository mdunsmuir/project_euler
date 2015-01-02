import Data.List
import Data.Digits

data NGon = NGon { inner :: [Int], outer :: [Int] } deriving Show

mkNGon :: [Int] -> NGon
mkNGon xs = let (o, i) = halves xs
            in  NGon o i

halves :: [a] -> ([a], [a])
halves xs = let halfLen = length xs `div` 2
            in  (take halfLen xs, drop halfLen xs)

nGonEdges (NGon is os) = 
  let ic = cycle is
  in  zipWith (:) os $ zipWith (\a b -> [a, b]) ic (tail ic)

isMagic :: NGon -> Bool
isMagic ng = 
  let edges = nGonEdges ng
  in  all ((sum (head edges) ==) . sum) $ tail edges

-- return a set of potential 'start' nodes for the inner and outer rings,
-- and the remaining elements to be arranged in the n-gon
startPairs :: [Int] -> [(Int, Int, [Int])]
startPairs xs = map (\(a, b) -> (a, b, delete a $ delete b $ xs)) allPairs
  where 
    allPairs = pairs ++ map (\(a, b) -> (b, a)) pairs
    pairs = concat $ map f $ (init . init) $ tails xs
    f (x':xs') = map (\y -> (x', y)) xs'

nGonsForStartPair :: (Int, Int, [Int]) -> [NGon]
nGonsForStartPair (a, b, xs) = let pHalves = map halves $ permutations xs
                               in  map (\(i, o) -> NGon (a:i) (b:o)) pHalves

allMagicNGons nDigits = 
  let digs = [1..(nDigits)]
  in  filter isMagic $ concat $ map nGonsForStartPair $ startPairs digs

string :: NGon -> Int
string ng = unDigits 10 $ concat $ map (digits 10) $ concat $ edges 
  where 
    edges' = nGonEdges ng 
    nEdges = length edges'
    minStart = minimum $ map head edges'
    edges = take nEdges $ dropWhile ((minStart /=) . head) $ cycle edges'


main = putStrLn $ show answer
  where
    answer = maximum $ filter ((==16) . length . digits 10) $ map string $ allMagicNGons 10
