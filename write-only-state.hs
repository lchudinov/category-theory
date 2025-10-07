module Main where
  
newtype Writer w a = Writer (a, w)

runWriter :: Writer w a -> (a, w)
runWriter (Writer (a, w)) = (a, w)


-- Functor
instance Functor (Writer w) where
  fmap f (Writer (a, w)) = Writer (f a, w)

-- Applicative
instance (Monoid w) => Applicative (Writer w) where
  pure a = Writer (a, mempty)
  (Writer (f, w1)) <*> (Writer (a, w2)) =
      Writer (f a, w1 `mappend` w2)

instance (Monoid w) => Monad (Writer w) where
  (Writer (a, w)) >>= k =
      let (a', w') = runWriter (k a)
      in Writer (a', w `mappend` w')

  return a = Writer (a, mempty)


-- Удобная функция для логирования
tell :: w -> Writer w ()
tell msg = Writer ((), msg)

-- Вычисление с логом
add :: Int -> Int -> Writer [String] Int
add x y = do
  tell ["Adding " ++ show x ++ " and " ++ show y]
  return (x + y)

mul :: Int -> Int -> Writer [String] Int
mul x y = do
  tell ["Multiplying " ++ show x ++ " and " ++ show y]
  return (x * y)

calc :: Writer [String] Int
calc = do
  a <- add 2 3
  b <- mul a 4
  return b

main :: IO ()
main = do
  let (result, log) = runWriter calc
  putStrLn $ "Result: " ++ show result
  putStrLn "Log:"
  mapM_ putStrLn log
