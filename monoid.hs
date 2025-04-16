module Monoid where
  
class Monoid m where
  mempty :: m
  mappend :: m -> m -> m
  
instance Monoid.Monoid String where
  mempty = ""
  mappend = (++)
  
x = "Hello " ++ "world!"
y = (++) "Hello " "world!"
