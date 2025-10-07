module Main where

newtype Reader e a = Reader (e -> a)

runReader :: Reader e a -> e -> a
runReader (Reader f) e = f e

instance Functor (Reader e) where
  fmap f (Reader g) = Reader (f . g)

instance Applicative (Reader e) where
  pure x = Reader (\_ -> x)
  Reader f <*> Reader g = Reader (\e -> f e (g e))

instance Monad (Reader e) where
  ra >>= k = Reader (\e -> runReader (k (runReader ra e)) e)
  -- return x = Reader (\e -> x)
  
ask :: Reader e e
ask = Reader id
  
example :: Reader String String
example = do
  env <- ask
  return ("Hello, " ++ env ++ "!")

main :: IO ()
main = putStrLn (runReader example "Leonty")