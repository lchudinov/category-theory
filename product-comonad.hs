module Main where

data Product e a = Prod e a deriving Functor

(=>=) :: (Product e a -> b) -> (Product e b -> c) -> (Product e a -> c)
f =>= g = \(Prod e a) -> let b = f (Prod e a)
                             c = g (Prod e b)
                         in c

extract (Prod e a) = a
  
main:: IO ()
main = putStrLn "Hello"