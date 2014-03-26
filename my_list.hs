infixr 5 :-: 

data List a = Empty
            | a :-: (List a)  
              deriving (Show)

lmap :: (a -> b) -> List a -> List b
lmap _ Empty      = Empty
lmap f (x :-: xs) = (f x) :-: lmap f xs

--lfoldl :: (b -> a -> b) -> List a -> b -> b
lfoldl _ memo Empty      = memo
lfoldl f memo (x :-: xs) = lfoldl f (f memo x) xs

instance Functor List where
  fmap = lmap
