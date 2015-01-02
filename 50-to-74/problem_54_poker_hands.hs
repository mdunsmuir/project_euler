import System.Environment
import Control.Monad
import Data.List 

-- Card type and friends

data Value = Two | Three | Four | Five
           | Six | Seven | Eight | Nine
           | Ten | Jack | Queen | King | Ace
           deriving (Eq, Ord, Enum)

data Suit = Clubs | Diamonds | Hearts | Spades
          deriving (Eq, Ord)

data Card = Card { value :: Value, suit :: Suit } deriving (Eq, Ord)

valueReadMap = [('2', Two), ('3', Three), ('4', Four), ('5', Five),
                ('6', Six), ('7', Seven), ('8', Eight), ('9', Nine),
                ('T', Ten), ('J', Jack), ('Q', Queen), ('K', King),
                ('A', Ace)]

suitReadMap = [('C', Clubs), ('D', Diamonds), 
               ('H', Hearts), ('S', Spades)]

instance Read Card where
  readsPrec _ input
    | length input < 2 = []
    | otherwise = let valueChar = head input
                      suitChar = input !! 1
                      parsed = do
                        value <- lookup valueChar valueReadMap
                        suit <- lookup suitChar suitReadMap
                        return $ Card value suit
                  in  case parsed of
                        (Just card) -> [(card, drop 2 input)]
                        Nothing     -> []

-- Hand type and friends

data Hand = Invalid
          | HighCard [Value]
          | OnePair Value [Value]
          | TwoPair Value Value [Value]
          | ThreeKind Value [Value]
          | Straight [Value]
          | Flush [Value]
          | FullHouse Value Value
          | FourKind Value [Value]
          | StraightFlush [Value]
          | RoyalFlush
          deriving (Eq, Ord)

areConsecutive :: [Value] -> Bool
areConsecutive values@(v:_)
  | v < Six   = False
  | otherwise = all (\(a, b) -> pred a == b) $ zip (init values) (tail values)

areSameSuit :: [Card] -> Bool
areSameSuit = (1 ==) . length . nub . map suit

toHand [] = Invalid
toHand cards'
  | length cards /= 5                 = Invalid

  | head values == Ace &&         
    areConsecutive values &&
    areSameSuit cards                 = RoyalFlush

  | areConsecutive values &&
    areSameSuit cards                 = StraightFlush values

  | any ((4 ==) . length) valueGroups = let ([four], [fifth]) = partition ((4 ==) . length) valueGroups
                                        in  FourKind (head four) fifth

  | length valueGroups == 2           = let ([three], [two]) = partition ((3 ==) . length) valueGroups
                                        in  FullHouse (head three) (head two)
  
  | areSameSuit cards                 = Flush values

  | areConsecutive values             = Straight values

  | any ((3 ==) . length) valueGroups = let ([three], rest) = partition ((3 ==) . length) valueGroups
                                        in  ThreeKind (head three) (concat rest)

  | length valueGroups == 3           = let (pairs, [remain]) = partition ((2 ==) . length) valueGroups
                                        in  TwoPair (head $ head pairs) (head $ last pairs) remain

  | any ((2 ==) . length) valueGroups = let ([pair], rest) = partition ((2 ==) . length) valueGroups
                                        in  OnePair (head $ pair) (concat rest)

  | otherwise                         = HighCard values

  where cards = reverse $ sort cards'
        values = map value cards
        valueGroups = group values

player1Wins handStr = let cards = map read $ words handStr :: [Card]
                          (cards1, cards2) = splitAt 5 cards
                      in  toHand cards1 > toHand cards2

main = do
  args <- getArgs
  if length args /= 1
    then putStrLn "gotta give a filename"
    else do
      myLines <- liftM lines $ readFile $ args !! 0
      let nWins = length $ filter id $ map player1Wins myLines
      putStrLn $ show nWins
