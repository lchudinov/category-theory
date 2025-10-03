module ListMonad where

import Control.Monad (guard)
  
-- instance Monad [] where
  -- join = concat
  -- return x = [x]
  -- xs >>= f = join (map f xs)
  -- (>>=) xs f = concat (map f xs)
  
triples = do
  z <- [1..]
  x <- [1..z]
  y <- [x..z]
  guard(x^2 + y^2 == z^2)
  return (x, y, z)
  
first10 = take 10 triples

triplesAgain = [(x, y, z) | z <- [1..]
                          , x <- [1..z]
                          , y <- [x..z]
                          , x^2 + y^2 == z^2]