{-# LANGUAGE InstanceSigs #-}
module Main where

class Functor w => Comonad w where
  extract :: w a -> a
  duplicate :: w a -> w (w a)
  extend :: (w a -> b) -> w a -> w b
  extend f = fmap f . duplicate

data Stream a = Cons a (Stream a)

instance Functor Stream where
  fmap :: (a -> b) -> Stream a -> Stream b
  fmap f (Cons a as) = Cons (f a) (fmap f as)

instance Comonad Stream where
  extract (Cons a _) = a

  duplicate (Cons a as) = Cons (Cons a as) (duplicate as)
  
tail :: Stream a -> Stream a
tail (Cons a as) = as

sumS :: Num a => Int -> Stream a -> a
sumS n (Cons a as) = if n <= 0 then 0 else a + sumS (n - 1) as

average :: Fractional a => Int -> Stream a -> a
average n stm = (sumS n stm) / (fromIntegral n)

movingAvg :: Fractional b => Int -> Stream b -> Stream b
movingAvg n = extend (average n)

main :: IO ()
main = putStrLn "Hello"