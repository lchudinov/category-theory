module ListFunctor where
  
data List' a = Nil' | Cons' a (List' a)

fmap':: (a -> b) -> (List' a -> List' b)
fmap' _ Nil' = Nil'
fmap' f (Cons' x t) = Cons' (f x) (fmap' f t)

instance Functor List' where
  fmap _ Nil' = Nil'
  fmap f (Cons' x t) = Cons' (f x) (fmap f t)
