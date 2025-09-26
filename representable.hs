{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FunctionalDependencies #-}

module Representable where
  
class Representable f where
  type Rep f :: *
  tabulate :: (Rep f -> x) -> f x
  index :: f x -> (Rep f -> x)
  
data Stream a = Cons a (Stream a)

instance Representable Stream where
  type Rep Stream :: Integer
  tabulate f = Cons (f 0) (tabulate (f * (+1)))
  index (Cons x xs) n = if n == 0 then x else index xs (n - 1)