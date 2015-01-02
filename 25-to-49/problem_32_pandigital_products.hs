import Data.List

numbers9Pandigital = map f $ filter has9PandigitalPair $ map factorPairs [1..10000]
  where f p = let p' = head p in fst p' * snd p'

has9PandigitalPair = any factorsAre9Pandigital

factorsAre9Pandigital pair = is9Pandigital [fst pair, snd pair, fst pair * snd pair]

is9Pandigital = isPandigital 9

isPandigital :: Int -> [Int] -> Bool
isPandigital numDigits = (allDigits==) . sort . concat . map show
  where allDigits = take numDigits ['1'..]

factorPairs :: Int -> [(Int, Int)]
factorPairs num = map (\x -> (x, num `quot` x)) $ filter ((==0) . (mod num)) $ potentialFactors num

potentialFactors num = takeWhile f [2..]
  where f = (<=(floor $ sqrt $ fromIntegral num))

main = putStrLn $ show $ sum numbers9Pandigital
