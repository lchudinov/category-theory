module FreeMonoid where
  
class Monoid m where
  mempty :: m
  mappend :: m -> m -> m
  
instance FreeMonoid.Monoid [a] where
  mempty = []
  mappend = (++)
  
instance FreeMonoid.Monoid String where
  mempty = ""
  mappend = (+)
  
