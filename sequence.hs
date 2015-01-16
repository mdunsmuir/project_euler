import Control.Monad
import Control.Applicative

sequence' :: (Applicative m, Monad m) => [m a] -> m [a]
sequence' [] = return []
sequence' (m:ms) = do
  m' <- m
  (m' :) <$> sequence' ms

sequence'' :: Monad m => [m a] -> m [a]
sequence'' [] = return []
sequence'' (m:ms) = do
  m' <- m
  ms' <- sequence'' ms
  return $ m' : ms'
               
