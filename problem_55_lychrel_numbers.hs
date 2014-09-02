isLychrel iter num
  | iter > 50    = True
  | isPalindrome = False
  | otherwise    = isLychrel (iter + 1) palNum
  where
    palNum = num + (read $ reverse $ show num)
    palStr = show palNum
    isPalindrome = palStr == reverse palStr                        

answer = length $ filter id $ map (isLychrel 1) [1..10000]

main = putStrLn $ show answer
