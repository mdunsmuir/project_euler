import qualified Data.HashTable as Hash
import Control.Applicative

triangleNumber n = truncate $ n * (n + 1) / 2
pentagonNumber n = truncate $ n * (3 * n - 1) / 2
hexagonNumber n = truncate $ n * (2 * n - 1)

start = 1
newIntHash = Hash.new (==) Hash.hashInt

firstAllThree :: IO Int
firstAllThree = do
  pentHash <- newIntHash
  hexHash <- newIntHash

  firstAllThree' start pentHash hexHash
  where
    firstAllThree' n pentHash hexHash = do
      let tri = triangleNumber n
          pent = pentagonNumber n
          hex = hexagonNumber n

      Hash.insert pentHash pent True
      Hash.insert hexHash hex True

      hasPent <- Hash.lookup pentHash tri
      hasHex <- Hash.lookup hexHash tri

      let isAnswer = (&&) <$> hasPent <*> hasHex

      case isAnswer of
        Just _  -> putStrLn $ show tri
        Nothing -> return ()

      firstAllThree' (n + 1) pentHash hexHash

main = firstAllThree
  
