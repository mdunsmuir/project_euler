import Data.List

data Triangle = Triangle Int (Int, Int, Int) deriving Show

perimeter (Triangle p _) = p

instance Eq Triangle where
  t1 == t2 = (perimeter t1 == perimeter t2)

instance Ord Triangle where
  t1 `compare` t2 = perimeter t1 `compare` perimeter t2

triangles maxP = [Triangle (a + b + c) (a, b, c) | c <- [1..(maxP - 2)],  
                                                   b <- [1..(min c (maxP - c))], 
                                                   a <- [1..(min b (maxP - c - b))],
                                                   a^2 + b^2 == c^2]

pCounts = let f l = (length l, perimeter $ head l)
          in  sort . map f . pSets
pSets = group . sort . triangles

main = putStrLn $ show $ last $ pCounts 1000
