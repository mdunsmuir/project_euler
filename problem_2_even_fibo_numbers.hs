fibo = 2 : 3 : (zipWith (+) fibo $ tail fibo)
answer = sum $ takeWhile (<= 4000000) $ concatMap (take 1) $ iterate (drop 3) $ fibo
