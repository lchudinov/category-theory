module ProductTypes where

swap :: (a, b) -> (b, a)
swap (x, y) = (y, x)

alpha :: ((a, b), c) -> (a, (b, c))
alpha ((x, y), z) = (x, (y, z))

alphaInv :: (a, (b, c)) -> ((a, b), c) 
alphaInv (x, (y, z)) = ((x, y), z)

rho :: (a, ()) -> a
rho (x, ()) = x
  
rhoInv :: a -> (a, ())
rhoInv x = (x, ())

data Pair a b = P a b

stmt :: Pair String Bool
stmt = P "This statement is" False

data Pair' a b = Pair' a b

stmt' = (,) "This statement is" False

data Stmt = Stmt String Bool