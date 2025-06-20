module CovariantContravariant where
import Data.Functor.Contravariant (Contravariant, contramap, Op)

type Reader' r a = r -> a

-- instance Functor (Reader' r) where
--   fmap :: (a -> b) -> (r -> a) -> (r -> b)
--   fmap f g = f . g

-- type Op' r a  = a -> r

-- fmap :: (a -> b) -> (a -> r) -> (b -> r)

-- class Contravariant f where
--   contramap :: (b -> a) -> (f a -> f b)
  
-- instance Contravariant (Op' r) where
-- (b -> a) -> Op r a -> Op r b
--   contramap f g = g . f
  
-- flip :: (a -> b -> c) -> (b -> a -> c)
-- flip f y x = f x y

-- contramap = flip (.)

x = fmap length (Just "hello")

newtype Printer a = Printer { runPrinter :: a -> String }

instance Contravariant Printer where
  contramap f (Printer g) = Printer (g . f)
  
intPrinter = Printer show
boolPrinter = contramap (\b -> if b then 1 else 0) intPrinter
y = runPrinter boolPrinter True

-- type Op' r a  = a -> r

-- instance Contravariant (Op r) where
--   contramap f g = g . f


--- fmap :: (a -> b) -> (r -> a) -> (r -> b)
--- fmap :: (a -> b) -> (a -> r) -> (b -> r)
