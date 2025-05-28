module Functors where
  
  
-- Mapping from type `a` to type `Maybe a`. it's an endofunctor because maps category of types to itself. 
-- data Maybe a = Nothing | Just a

-- f :: a -> b

-- f' :: Maybe a -> Maybe a
-- f' Nothing = Nothing
-- f' (Just x) = Just (f x)

fmap :: (a -> b) -> Maybe a -> Maybe b
fmap _ Nothing = Nothing
fmap f (Just x) = Just (f x)

--   fmap id Nothing
-- = { definition of fmap }
--   Nothing
-- = {defintition of id}
--   id Nothing

--   fmap id (Just x)
-- = { definition of fmap }
--   Just (id x)
-- = { definition of id }
--   Just x
-- = { definition of id }
--   id (Just x)

fmap (g . f) = fmap g . fmap f

--   fmap (g . f) Nothing
-- = { definition of fmap }
--   Nothing
-- = { definition of fmap }
--   fmap g Nothing
-- = { definition of fmap }
--   fmap g (fmap f Nothing)

--   fmap (g . f) (Just x)
-- = { definition of fmap }
--   Just ((g . f) x)
-- = { definition of composition }
--   Just ((g (f x))
-- = { definition of fmap }
--   fmap g (Just (f x)))
-- = { definition of fmap }
--   fmap g (fmap f (Just x)))
-- = { definition of composition }
--   (fmap g . fmap f) (Just x)

