module Challenges7 where 
import Monoid (x)

-- 1.
-- Can we turn the Maybe type constructor into a functor by defining:
-- fmap _ _ = Nothing
-- which ignores both of its arguments? (Hint: Check the functor laws.)

-- It breaks the identity law for functors.
-- The identity law
-- fmap id x == x
-- fmap id (Just 42) = Nothing
--

-- 2.
-- Prove functor laws for the reader functor. Hint: it’s really simple.
fmap' = (.)

-- fmap' id x == x
-- id . x = x

-- fmap (f . g) x = fmap f (fmap g x)
-- fmap f (fmap g x) = fmap f (g . x) = f . (g . x)
-- fmap (f . g) x = (f . g) . x = f . (g . x)

-- 3. Implement the reader functor in your second favorite language
-- (the first being Haskell, of course).
-- See reader.ts

-- 4. Prove the functor laws for the list functor. Assume that the laws
-- are true for the tail part of the list you’re applying it to (in other
-- words, use induction).

-- data List a = Nil | Cons a (List a)

-- fmap:: (a -> b) -> (List a -> List b)
-- fmap _ Nil = Nil
-- fmap f (Cons x t) = Cons (f x) (fmap f t)

-- instance Functor List where
--   fmap _ Nil = Nil
--   fmap f (Cons x t) = Cons (f x) (fmap f t)

-- fmap id x = x
-- fmap id Nil = Nil
-- fmap id (Cons x t) = Cons (id x) (fmap id t) = Cons x (fmap id t) = Cons x t

-- fmap (f . g) x = fmap f (fmap g x)
-- fmap (f . g) Nil = Nil
-- fmap f (fmap g Nil) = fmap f Nil = Nil

-- fmap (f . g) (Cons x xs) = fmap f (fmap g (Cons x xs))
 

-- fmap (f . g) x (Cons x xs) = Cons ((f . g) x) fmap ((f . g) xs)
-- fmap f (fmap g (Cons x xs)) = fmap f (Cons ((g x) (fmap g xs))) = Cons (f (g x)) fmap f (fmap g xs) =

--   Apply Inductive hypothesis: fmap (f . g) xs = fmap f (fmap g xs)

-- =  Cons (f (g x)) fmap (f . g) xs