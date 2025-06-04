module FunctorsAsContainers where

myNats :: [Integer]
myNats = [1..]

data Const c a = Const c

instance Functor (Const c) where
  fmap _ (Const v) = Const v