{-# LANGUAGE DeriveFunctor #-}

module FunctorialAlgebraicDataTypes where
import Data.Bifunctor (Bifunctor (bimap))
  
data Identity' a = Identity' a

instance Functor Identity' where
  fmap f (Identity' x) = Identity' (f x)
  
data Maybe' a = Nothing' | Just' a

data Const c a = Const c

type Maybe'' a = Either (Const () a) (Identity' a)

newtype BiComp bf fu gu a b = BiComp (bf (fu a) (gu b))

instance (Bifunctor bf, Functor fu, Functor gu) => 
  Bifunctor (BiComp bf fu gu ) where
    bimap f1 f2 (BiComp x) = BiComp ((bimap (fmap f1) (fmap f2)) x)
    
data Maybe''' a = Nothing''' | Just''' a deriving Functor -- the corresponding fmap will be implemented for you.

data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Functor