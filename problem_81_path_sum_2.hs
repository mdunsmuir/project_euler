import System.Environment
import Control.Monad
import Control.Monad.State.Strict
import Data.List
import qualified Data.Vector as V
import qualified Data.Sequence as S
import qualified Data.HashMap.Strict as M

-- matrix type

type Matrix a = V.Vector (V.Vector a)

dims :: Matrix a -> (Int, Int)
dims m = (V.length m, V.length $ m V.! 0)

at :: Matrix a -> Int -> Int -> a
at m x y = m V.! y V.! x

-- special neighbors function for this problem in particular
neighbors :: Matrix a -> Int -> Int -> [(Int, Int)]
neighbors m x y =
  let (w, h) = dims m
  in  do
    -- these two lines set the configuration of the neighbors
    incr <- [(+ 1), (subtract 1)]
    n <- [(x, incr y), (incr x, y)]
    --n <- [(x + 1, y), (x, y + 1), (x, y - 1)]

    -- make sure they are legal neighbors
    let (x', y') = n
    guard $ x' >= 0 && y' >= 0
    guard $ x' < w && y' < h
    return n

-- importing the matrix

splitOn :: Eq a => a -> [a] -> [[a]]
splitOn c str = filter (not . null) $ splitOn' c str
  where
    splitOn' c [] = []
    splitOn' c str = case break (c ==) str of
                       (pre, (_:post)) -> pre : splitOn' c post
                       (pre, []) -> [pre]

importMatrix :: String -> IO (Matrix Int)
importMatrix fileName = do
  contents <- readFile fileName
  let dataLines = lines contents
      splitLines = map (map read . splitOn ',') dataLines
  return $ V.fromList $ map V.fromList splitLines

-- DSL-ish that we're going to use

data PathState = PathState { queue :: S.Seq (Int, Int),
                             sums :: M.HashMap (Int, Int) Int,
                             matrix :: Matrix Int }

enq :: (Int, Int) -> State PathState ()
enq n = do
  (PathState q s m) <- get
  let q' = q S.|> n
  put $ PathState q' s m

deq :: State PathState (Maybe (Int, Int))
deq = do
  (PathState q s m) <- get
  if S.null q
    then return Nothing
    else do
      let node = S.index q 0
          q' = S.drop 1 q
      put $ PathState q' s m
      return $ Just node

sumFor :: (Int, Int) -> State PathState (Maybe Int)
sumFor node = do
  (PathState _ sums _) <- get
  return $ M.lookup node sums

setSum :: (Int, Int) -> Int -> State PathState ()
setSum node s = do
  (PathState q sums m) <- get
  let sums' = M.insert node s sums
  put $ PathState q sums' m

getMatrix :: State PathState (Matrix Int)
getMatrix = fmap matrix get

-- the algorithm

initState :: Matrix Int -> PathState
initState m =
  let is = PathState S.empty M.empty m
  in  flip execState is $ do
        m <- getMatrix
        enq (0, 0)
        let s = at m 0 0
        setSum (0, 0) s

findPath :: State PathState (Maybe Int)
findPath = do
  m <- getMatrix
  node <- deq
  case node of
    Just n' -> processNode n' >> findPath
    Nothing -> currentBest

currentBest = do
  m <- getMatrix
  let (w, h) = dims m
  sumFor (w - 1, h - 1)

processNode :: (Int, Int) -> State PathState ()
processNode node@(x, y) = do
  m <- getMatrix
  cb <- currentBest
  (Just s) <- sumFor node

  forM_ (neighbors m x y) $ \n@(nx, ny) -> do
    ns <- sumFor n

    let baseSum = s + at m nx ny
        someLogic = case ns of
          Just ns' -> if ns' < baseSum then return () else do
            enq n
            setSum n baseSum
          Nothing -> do
            setSum n baseSum
            enq n

    case cb of
      Just cb' -> if cb' <= baseSum then return () else someLogic
      Nothing -> someLogic

-- main

main = do
  args <- getArgs
  if length args == 1
    then do
      m <- importMatrix $ head args
      let is = initState m
          ans = evalState findPath is
      putStrLn $ show ans
    else putStrLn "gotta give a matrix filename"
