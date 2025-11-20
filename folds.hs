module Folds where

data ListF e a = NilF | ConsF e a

-- data List e = Nil | Cons e (List e)

lenAlg :: ListF e Int -> Int
lenAlg (ConsF e n) = n + 1
lenAlg NilF = 0

length :: [a] -> Int
length = foldr (\e n -> n + 1) 0

sumAlg :: ListF Double Double -> Double
sumAlg (ConsF e s) = e + s
sumAlg NilF = 0.0

sum :: [Double]-> Double
sum = foldr (\e s -> e + s) 0.0