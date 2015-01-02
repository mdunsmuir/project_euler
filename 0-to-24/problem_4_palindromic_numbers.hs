import System.Environment
import Data.List
import qualified Data.Foldable as F
import Data.Digits

answer nDigits = 
  let start = 1 + (unDigits 10 $ 1 : replicate (nDigits - 1) 0)
      end = unDigits 10 $ replicate nDigits 9
      nums = reverse [start..end]
      answerFold oldMax (x:xs) =
        maybe oldMax id $ F.find isPalindrome $ takeWhile (oldMax <) $ fmap (x *) (x:xs)
  in  F.foldl answerFold (start^2) $ init $ tails nums
 
isPalindrome = (\p -> p == reverse p) . digits 10

main = do
  args <- getArgs
  if length args /= 1
    then putStrLn "must give # of digits"
    else putStrLn $ show $ answer $ read $ head args
