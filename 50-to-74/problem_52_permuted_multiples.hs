import Data.List
import qualified Data.Set as S

answer = let toSet = S.fromList . show
             isAnswer x = all (toSet x ==) [toSet $ x * m | m <- [2..6]]
         in  find isAnswer [1..]

main = putStrLn $ show answer
