module Main where

-- Определяем State
newtype State s a = State { runState :: s -> (a, s) }

-- Functor
instance Functor (State s) where
  fmap f (State sa) = State $ \s ->
    let (a, s') = sa s
    in (f a, s')

-- Applicative
instance Applicative (State s) where
  pure a = State $ \s -> (a, s)
  (State sf) <*> (State sa) = State $ \s ->
    let (f, s1) = sf s
        (a, s2) = sa s1
    in (f a, s2)

-- Monad
instance Monad (State s) where
  (State sa) >>= k = State $ \s ->
    let (a, s') = sa s
    in runState (k a) s'

-- get
get :: State s s
get = State $ \s -> (s, s)

-- put
put :: s -> State s ()
put s' = State $ \_ -> ((), s')

-- Пример использования
main :: IO ()
main = do
  let increment = do
        x <- get
        put (x + 1)
        get
      (result, finalState) = runState increment 5
  putStrLn $ "Result: " ++ show result
  putStrLn $ "Final state: " ++ show finalState
