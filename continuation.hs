{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
module Main where

newtype Cont r a = Cont { runCont :: (a -> r) -> r }

instance Functor (Cont r) where
  fmap f (Cont k) = Cont (\br -> k (br . f))

instance Applicative (Cont r) where
  pure a = Cont (\ar -> ar a)
  (Cont kf) <*> (Cont ka) = Cont (\br -> kf (\f -> ka (br . f)))

instance Monad (Cont r) where
  (Cont ka) >>= kab = Cont (\br -> ka (\a -> runCont (kab a) br))
  return = pure

example :: Cont r String
example = do
  x <- Cont $ \k -> k "Hello"
  y <- Cont $ \k -> k "World"
  return (x ++ " " ++ y)

main :: IO ()
main = putStrLn $ runCont example id
