import Data.List

pdc :: Int -> Maybe Int
pdc n = let concats = scanl1 (++) $ map (show . (n*)) [1..]
        in fmap read $ find ((=="123456789") . sort) $ takeWhile ((<10) . length) concats

allPdc = map pdc [1..9999] >>= (\p -> case p of
                                        (Just x) -> [x]
                                        Nothing  -> [] )

main = putStrLn $ show $ last allPdc
