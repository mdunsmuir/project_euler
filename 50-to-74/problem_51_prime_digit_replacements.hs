import Data.List
import qualified Data.ByteString as B
import qualified Data.ByteString.Search as S
import Control.Monad
import Control.Applicative
import System.Environment
import Primes
import qualified Eratosthenes as E

integers = [0..]
digits = ['0'..'9']

digitMasks = map (\i -> filter ((0 <) . length) $ subsequences $ take i integers) integers

answer len = find ((len <=) . length) $ do
  prime <- primes
  let numStr = show prime
      numLen = length numStr
  mask <- digitMasks !! numLen
  let set = map (\d -> replaceDigits mask d numStr) digits
  return $ filter isPrime $ nub $ map read $ filter ((not . ('0'==)) . head) set

replaceDigits mask newDigit numStr = replaceDigits' mask 0 numStr
  where
    replaceDigits' [] _ ds = ds
    replaceDigits' mask i (d:ds)
      | i == i'   = newDigit : replaceDigits' (tail mask) (i + 1) ds
      | otherwise = d : replaceDigits' mask (i + 1) ds
      where i' = head mask

main = do
  args <- getArgs
  if length args /= 1
    then putStrLn "must give target set size"
    else putStrLn $ show $ sort <$> (answer $ read $ head args)

getSets num = do
  realDigit <- realDigits
  replaceDigit numStr realDigit
  where numStr = B.show num :: B.ByteString
        realDigits = nub numStr

replaceDigit numStr digit = do
  newDigit <- digits
  return $ S.replace (B.singleton digit) (B.singleton newDigit) numStr
