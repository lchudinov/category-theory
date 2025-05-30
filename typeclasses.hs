module TypeClasses where
  
-- class Eq a where
--   (==) :: a -> a -> Bool
  
data Point = Pt Float Float

instance Eq Point where
  (Pt x y) == (Pt x' y') = x == x' && y == y'
  
-- class Functor f where
--   fmap :: (a -> b) -> f a -> f b

-- instance Functor Maybe where
--   fmap _ Nothing = Nothing
--   fmap f (Just x) = Just (f x)
