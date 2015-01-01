fizzBuzz = mapM_ putStrLn $ zipWith3 z [1..100] (fbCycle 3 "Fizz") (fbCycle 5 "Buzz")
  where z n f b = let fb = f ++ b in if null fb then show n else fb
        fbCycle n s = cycle (replicate (n - 1) "" ++ [s])
