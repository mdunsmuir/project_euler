collatzLen x = collatzLen' x 0
  where collatzLen' x' l
          | x' == 1 = l + 1
          | otherwise = collatzLen' next (l + 1)
          where next
                  | even x' = x' `div` 2
                  | otherwise = 3 * x' + 1

longestCollatz max = foldr try (1, 1) [1..max]
  where try x p@(prevMax, prevLen)
          | len > prevLen = (x, len)
          | otherwise = p
          where len = collatzLen x

main = putStrLn $ show $ longestCollatz 999999
