import System.Directory
import Data.Maybe (isJust)
import Data.List
import qualified Data.Foldable as F
import qualified Data.Map.Lazy as M
import System.Process
import Text.RegexPR (matchRegexPR)

regex = "^problem_([0-9]+).*\\.(hs|rb|lua|py|c)$"
dirSize = 25

-- main code
main = do
  contents <- allFiles
  let dirMapping = sortIntoDirectories $ problemsWithIDs contents
  F.mapM_ moveFiles $ M.toList dirMapping

allFiles = do
  cwd <- getCurrentDirectory
  getDirectoryContents cwd

-- code for moving files into directories
moveFiles :: (String, [String]) -> IO ()
moveFiles (dn, fns) = do
  createDirectoryIfMissing False dn
  let cmd = "git mv " ++ intercalate " " fns ++ " " ++ dn
  putStrLn cmd
  handle <- spawnCommand cmd
  status <- waitForProcess handle
  putStrLn $ show status

-- code for sorting files
directoryForID :: Int -> String
directoryForID id = let start = (id `div` dirSize) * dirSize
                        end = start + dirSize - 1
                    in  show start ++ "-to-" ++ show end

sortIntoDirectories :: [(Int, String)] -> M.Map String [String]
sortIntoDirectories = F.foldr f M.empty
  where
    f (id, fn) m = let dirName = directoryForID id
                   in  M.insertWith (++) dirName [fn] m
 

problemsWithIDs :: [String] -> [(Int, String)]
problemsWithIDs fs = map mapFun matches
  where 
    matches = filter isJust $ map (matchRegexPR regex) fs
    mapFun (Just ((f,_), [_,(1, id)])) = (read id, f)
