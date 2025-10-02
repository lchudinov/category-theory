module DoNotation where
  
import Data.Char (toUpper)

newtype Writer w a = Writer (a, w)
  deriving Show  -- чтобы можно было печатать результат в GHCI

runWriter :: Writer w a -> (a, w)
runWriter (Writer x) = x

instance Monoid w => Functor (Writer w) where
  fmap f (Writer (a, w)) = Writer (f a, w)
  
instance Monoid w => Applicative (Writer w) where
  pure a = Writer (a, mempty)
  (Writer (f, w1)) <*> (Writer (a, w2)) = Writer (f a, w1 <> w2)
  
instance Monoid w => Monad (Writer w) where
  (Writer (a, w1)) >>= f =
    let Writer (b, w2) = f a
    in Writer (b, w1 <> w2)


upCase :: String -> Writer String String
upCase s = Writer (map toUpper s, "upCase ")

toWords :: String -> Writer String [String]
toWords s = Writer (words s, "toWords ")

tell :: w -> Writer w ()
tell s = Writer ((), s)

process :: String -> Writer String [String]
process s = do
  upStr <- upCase s
  tell "toWords "
  return (words upStr)