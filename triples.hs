module Main where
  
-- e:\ghcup\bin\runghc.exe triples.hs
-- e:\ghcup\bin\ghc.exe triples.hs -o triples

import Control.Monad (guard)
  
 
triples = do
  z <- [1..]
  x <- [1..z]
  y <- [x..z]
  guard(x^2 + y^2 == z^2)
  return (x, y, z)
  
first10 = take 10 triples

main :: IO()
main = print first10

-- 