{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
import Data.Bifunctor
import Data.Functor.Identity

-- 1. Show that the data type:
-- data Pair a b = Pair a b
-- is a bifunctor. For additional credit implement all three methods
-- of Bifunctor and use equational reasoning to show that
-- these definitions are compatible with the default implementations
-- whenever they can be applied.

data Pair a b = Pair a b

instance Bifunctor Pair where
  bimap f g (Pair x y) = Pair (f x) (g y)
  first f (Pair x y) = Pair (f x) y
  second g (Pair x y) = Pair x (g y)
  
-- 2. Show the isomorphism between the standard definition of Maybe
-- and this desugaring:
-- type Maybe' a = Either (Const () a) (Identity a)
-- Hint: Define two mappings between the two implementations.
-- For additional credit, show that they are the inverse of each other
-- using equational reasoning.

type Maybe' a = Either (Const () a) (Identity a)

data Const c a = Const c

convertTo :: Maybe' a -> Maybe a
convertTo (Left (Const ())) = Nothing
convertTo (Right (Identity x)) = Just x

convertFrom :: Maybe a -> Maybe' a
convertFrom Nothing = Left (Const ())
convertFrom (Just x) = Right (Identity x) 

-- convertTo . convertFrom = id

-- convertFrom . convertTo = id

-- 3. Let’s try another data structure. I call it a PreList because it’s a
-- precursor to a List. It replaces recursion with a type parameter b.
-- data PreList a b = Nil | Cons a b
-- You could recover our earlier definition of a List by recursively
-- applying PreList to itself (we’ll see how it’s done when we talk
-- about fixed points).
-- Show that PreList is an instance of Bifunctor.

data PreList a b = Nil | Cons a b

instance Bifunctor PreList where
    bimap _ _ Nil = Nil
    bimap f g (Cons x y) = Cons (f x) (g y)
    first _ Nil = Nil
    first f (Cons x y) = Cons (f x) y
    second _ Nil = Nil
    second g (Cons x y) = Cons x (g y)

-- 4. Show that the following data types define bifunctors in a and b:
-- data K2 c a b = K2 c
-- data Fst a b = Fst a
-- data Snd a b = Snd b
-- For additional credit, check your solutions against Conor
-- McBride’s paper Clowns to the Left of me, Jokers to the Right(http://strictlypositive.org/CJ.pdf)

data K2 c a b = K2 c
data Fst a b = Fst a
data Snd a b = Snd b

instance Bifunctor (K2 c) where
  bimap _ _ (K2 c) = K2 c
  first _ (K2 c) = K2 c
  second _ (K2 c) = K2 c
  
instance Bifunctor Fst where
  bimap f g (Fst a) = Fst (f a)
  first f (Fst a) = Fst (f a)
  second _ (Fst a) = Fst a
  
instance Bifunctor Snd where
  bimap f g (Snd b) = Snd (g b)
  first _ (Snd b) = Snd b
  second g (Snd b) = Snd (g b)

-- 5. Define a bifunctor in a language other than Haskell. Implement
-- bimap for a generic pair in that language.
-- See bifunctor.ts

-- 6. Should std::map be considered a bifunctor or a profunctor in the
-- two template arguments Key and T? How would you redesign this
-- data type to make it so? Profunctor