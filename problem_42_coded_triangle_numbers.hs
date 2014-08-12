import System.Environment
import Data.Char
import Data.List

isTriangleNumber :: Int -> Bool
isTriangleNumber num = tCheck 1 num
  where
    tCheck level remaining 
      | remaining == level = True
      | remaining < level  = False
      | otherwise          = tCheck (level + 1) (remaining - level)

main = do
  args <- getArgs
  if length args == 1
    then processWords $ head args
    else putStrLn "must give a filename"

processWords fileName = do

  -- get the list of words
  fileData <- readFile fileName
  let splitWords' = splitStr ',' fileData
      splitWords = map (filter (not . (=='"'))) splitWords'

      -- convert them to their 'coded' numbers
      codes = map strToCode splitWords

      -- filter for triangle numbers
      triangleCodes = filter isTriangleNumber codes

  putStrLn $ "there are " ++ show (length triangleCodes) ++ " triangle numbers in the given file"

strToCode :: String -> Int
strToCode = foldr1 (+) . map ((\x -> x - 64) . fromEnum)

splitStr :: Char -> String -> [String]
splitStr chr = filter (not . null) . foldr f [[]]
  where
    f next acc
      | next == chr = [] : acc
      | otherwise   = (next : head acc) : (tail acc)
