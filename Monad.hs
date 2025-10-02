module Monad where
import Data.Char (toUpper)

-- The Kleisli Category

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

-- Fish Anatomy

-- (>=>) :: (a -> m b) -> (b -> m c) -> (a -> m c)
-- f >=> g = \a -> let mb = f a in ..

class MonadHaskell m where
  (>>=) :: m a -> (a -> m b) -> m b
  return2 :: a -> m a
  
instance Monoid w => MonadHaskell (Writer w) where
  (Writer (a, w)) >>= f  =
    let Writer (b, w') = f a
    in Writer (b, w `mappend` w')
  return2 a = Writer (a, mempty)

class Functor m => BetterMonad m where
  join :: m (m a) -> m a
  return3 :: a -> m a
  
fmap f ma = ma Monad.>>= \a -> Monad.return (f a)

join2 :: Monoid w => Writer w (Writer w a) -> Writer w a
join2 (Writer ((Writer (a, w')), w)) = Writer (a, w `mappend` w')

