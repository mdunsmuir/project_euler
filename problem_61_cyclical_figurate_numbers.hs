import Control.Monad.State.Strict
import Data.List
import Data.Digits

data Figurate = Triangle | Square | Pentagon | Hexagon
              | Heptagon | Octagon deriving (Eq, Ord, Show)

setify :: (Int -> Int) -> [Int]
setify f = dropWhile (1000 >) $ takeWhile (9999 >) $ map f [1..]

triangles = setify (\n -> n * (n + 1) `div` 2)
squares = setify (^2)
pentagons = setify (\n -> n * (3 * n - 1) `div` 2)
hexagons = setify (\n -> n * (2 * n - 1))
heptagons = setify (\n -> n * (5 * n - 3) `div` 2)
octagons = setify (\n -> n * (3 * n - 2))

figurateMap = [(Triangle, triangles), (Square, squares), 
               (Pentagon, pentagons), (Hexagon, hexagons), 
               (Heptagon, heptagons), (Octagon, octagons)]

x `hasNext` y = let dx = digits 10 x
                    dy = digits 10 y
                in  (drop 2 dx) == (take 2 dy)

findCycles shapes = filter (not . null) $ iter [] shapes
  where
    iter prevs [] = if (head prevs) `hasNext` (last prevs)
                      then return (reverse prevs)
                      else return []

    iter prevs fs = do
      f <- if null prevs then return (head fs) else fs
      let (Just figNums) = lookup f figurateMap
          fs' = delete f fs
      next <- if null prevs 
                then figNums 
                else filter ((head prevs) `hasNext`) figNums
      iter (next : prevs) fs'

main = putStrLn $ show $ sum $ head $ findCycles $ map fst figurateMap
