import qualified Data.ByteString as B
import qualified Data.Set as S
import Data.Char
import Data.List
import GHC.Word
import Data.Bits

charToWord :: Char -> Word8
charToWord = toEnum . fromEnum
wordToChar :: Word8 -> Char
wordToChar = toEnum . fromEnum

strToBStr = B.pack . map charToWord
bStrToStr = map wordToChar . B.unpack

newline = charToWord '\n'
space = charToWord ' '

splitString c str = let (first, rest) = break (c ==) str 
                    in  case rest of
                          ""        -> filter (not . null) [first]
                          otherwise -> first : splitString c (tail rest)

crypt :: B.ByteString -> B.ByteString -> B.ByteString
crypt str key = let nConcat = max (1 + (B.length str) `div` (B.length key)) 1
                    fullKey = B.concat $ replicate nConcat key
                    xorPair (c, k) = c `xor` k
                in  B.pack $ map xorPair $ B.zip str fullKey

strCrypt str key = bStrToStr $ crypt (strToBStr str) (strToBStr str)

getDictionary :: String -> IO (S.Set B.ByteString)
getDictionary fileName = do
  contents <- B.readFile fileName
  return $ S.fromList $ filter (not . (0 ==) . B.length) $ B.split newline contents

getCipherText fileName = do
  contents <- readFile fileName
  let charValues = map read $ splitString ',' contents :: [Int]
      words = map chr charValues :: [Char]
  return $ strToBStr words

testString :: (S.Set B.ByteString) -> Int -> B.ByteString -> Bool
testString dict nCheck str = let words = B.split space str
                             in  any ((flip S.member) dict) $ take nCheck words

keys = map strToBStr [[a, b, c] | a <- ['a'..'z'], b <- ['a'..'z'], c <- ['a'..'z']]

getKeys dict str = filter (testString dict 4 . crypt str) $ keys

{-
matchingKeys :: String -> String -> IO [B.ByteString]
matchingKeys dictName cipherName = do
  dict <- getDictionary dictName
  cText <- getCipherText cipherName
  let key = case getKey dict cText of
              (Just k) -> k
              Nothing  -> B.empty
  putStrLn $ show $ crypt cText key
  return key
-}
