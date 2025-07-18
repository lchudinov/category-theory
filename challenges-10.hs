module Challenges10 where
  
-- 1. Define a natural transformation from the Maybe functor to the list
-- functor. Prove the naturality condition for it.

alaha1 :: Maybe a -> [a]
alaha1 Nothing = []
alpha1 (Just x) = [x]

-- 2. Define at least two different natural transformations between
-- Reader () and the list functor. How many different lists of ()
-- are there?

type Reader a = () -> a

alpha2 :: Reader a -> [a]
alpha2 r = [r ()]

alpha3 :: Reader a -> [a]
alpha3 r = [r (), r ()]

-- 3. Continue the previous exercise with Reader Bool and Maybe.

type ReaderB a = Bool -> a

alpha4 :: ReaderB a -> Maybe a
alpha4 r = Just (r True)

-- 4. Show that horizontal composition of natural transformation satisfies
-- the naturality condition (hint: use components). It’s a good
-- exercise in diagram chasing.

-- 5. Write a short essay about how you may enjoy writing down the
-- evident diagrams needed to prove the interchange law.

-- 6. Create a few test cases for the opposite naturality condition of
-- transformations between different Op functors. Here’s one choice:
-- op :: Op Bool Int
-- op = Op (\x -> x > 0)
-- and
-- f :: String -> Int
-- f x = read x