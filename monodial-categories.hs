module Main where
  
class Monoid m where
  mappend :: m -> m -> m
  mempty :: m
  
class Monoid2 m where
  mu :: (m, m) -> m
  eta :: () -> m
  
-- mu (x, mu (y, z)) = mu (mu (x, y), z)
-- (mu . bimap id mu)(x, (y, z)) = (mu . bimap mu id)((x, y), z)

-- alpha :: ((a, b) -> c) -> (a, (b, c))
-- alpha ((x, y), z) = (x, (y, z))

-- mu . bimap id mu . alpha = mu . bimap mu id

-- mu (eta (), x) = x
-- mu (x, eta ()) = x

-- (mu . bimap eta id) ((), x) = lambda((), x)
-- (mu . bimap id eta) (x, ()) = rho (x, ())

lambda :: ((), a) -> a
lambda ((), x) = x

rho :: (a, ()) -> a
rho (x, ()) = x

-- mu . bimap id eta = rho
-- mu . bimap eta id = lambda

main :: IO ()
main = putStrLn "Hello"