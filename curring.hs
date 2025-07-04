module Currying where
  
catstr :: String -> String -> String
catstr s s' = s ++ s'

catstr' s = \s' -> s ++ s'

greet :: String -> String
greet = catstr "Hello "

curry :: ((a, b) -> c) -> (a -> b -> c)
curry f a b = f (a, b)

uncurry :: (a -> b -> c) -> ((a, b) -> c)
uncurry f (a, b) = f a b

factorizer :: ((a, b) -> c) -> (a -> (b -> c))
factorizer g = \a -> (\b -> g (a, b))