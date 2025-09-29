module Monad where
  
class Monad m where
  (>=>) :: (a -> m b) -> (b -> m c) -> (a -> m c)
  return :: a -> m a
  
-- (f >=> g) >=> h = f >=> (g >=> h)  -- associativity
-- return >=> f = f                   -- left unit
-- f >=> return = f                   -- right unit  


newtype Writer w a = Writer (a, w)

instance Functor (Writer w) where
  fmap f (Writer (a, w)) = Writer (f a, w)
  
instance Monoid w => Monad.Monad (Writer w) where
  f >=> g = \a ->
    let Writer (b, s) = f a
        Writer (c, s') = g b
    in Writer (c, s `mappend` s')
  return a = Writer (a, mempty)
  
tell :: w -> Writer w ()
tell s = Writer ((), s)