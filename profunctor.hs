module Profunctor where
  
class Profunctor p where
  dimap :: (a -> b) -> (c -> d) -> p b c -> p a d
  dimap f g = lmap f . rmap g
  lmap :: (a -> b) -> p b c -> p a c
  lmap f = dimap f id  
  rmap :: (b -> c) -> p a b -> p a c
  rmap = dimap id
  
instance Profunctor (->) where
  dimap ab cd bc = cd . bc . ab
  lmap :: (a -> b) -> (b -> c) -> a -> c
  lmap = flip (.)
  rmap = (.)