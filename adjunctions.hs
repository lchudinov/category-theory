{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}

module Adjunctions where

  
swap :: (a, b) -> (b, a)
swap (a, b) = (b, a)

-- return :: d -> m d
-- extract :: w c -> c

class Representable f where
  type Rep f :: *
  tabulate :: (Rep f -> x) -> f x
  index :: f x -> (Rep f -> x)

class (Functor f, Representable u) =>
  Adjunction f u | f -> u, u -> f where
    unit :: a -> u (f a)
    counit :: f (u a) -> a
    
factorizer :: (c -> a) -> (c -> b) -> (c -> (a, b))
factorizer p q = \x -> (p x, q x)

-- fst . factorizer p q = p
-- snd . factorizer p q = q

toNat :: [()] -> Int
toNat = length

toLst :: Int -> [()]
toLst = replicate n ()