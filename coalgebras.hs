module Coalgebras where
  
import Recursion
import CataMorphisms


ana :: Functor f => (a -> f a) -> a -> Fix f
ana coalg = Fix . fmap (ana coalg) . coalg

data StreamF e a = StreamF e a
  deriving Functor
  
data Stream e = Stream e (Stream e)

era :: [Int] -> StreamF Int [Int]
era (p : ns) = StreamF p (filter (notdiv p) ns)
    where notdiv p n = n `mod` p /= 0
    
primes = ana era [2..]

toListC :: Fix (StreamF e) -> [e]
toListC = cata al
  where al :: StreamF e [e] -> [e]
        al (StreamF e a) = e : a
        
-- unfoldr :: (b -> Maybe (a, b)) -> b -> [a]

-- set :: a -> s -> a
-- get :: a -> s