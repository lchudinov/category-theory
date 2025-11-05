module Main where
  
data Store s a = Store (s -> a) s

class Functor w => Comonad w where
  extract :: w a -> a
  duplicate :: w a -> w (w a)
  extend :: (w a -> b) -> w a -> w b
  extend f = fmap f . duplicate

instance Comonad (Store s) where
  extract (Store f s) = f s
  duplicate (Store f s) = Store (Store f) s
  
main :: IO ()
main = putStrLn "Hello"