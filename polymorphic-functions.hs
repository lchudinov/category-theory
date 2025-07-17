-- {-# LANGUAGE RankNTypes #-}
module PolymorphicFunctions where
  
-- alpha :: forall a . F a -> G a
alpha :: F a -> G a

safeHead :: [a] -> Maybe b
safeHead [] = Nothing
safeHead (x:xs) = Just x

length :: [a] -> Const Int a
length [] = Const 0
length (x:xs) = Const (1 + unConst (length xs))

unConst :: Const c a -> c
unConst (Const x) = x

scam :: Const Int a -> Maybe a
scam (Const x) = Nothing

newtype Reader e a -> Reader (e -> a)

instance Functor (Reader e) where
  fmap f (Reader g) = Reader (\x -> f (g x))

-- alpha :: Reader () a -> Maybe a

dump (Reader _) = Nothing

obvious (Reader g) = Just (g ())

newtype Or r a = Op (a -> r)

instance Contravariant (Op r) where
  contramap f (Op g) = Op (g . f)
  
predToStr (Op f) = Op (\x -> if f x then "T" else "F")

-- contramap f . predToStr = predToStr . contramap f


