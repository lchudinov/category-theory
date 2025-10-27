module Main where
import Adjunctions (Adjunction)
  
newtype State s a = State(s -> (a, s))
newtype Prod s a = Prod (a, s)
newtype Reader s a = Reader (s -> a)

-- instance Adjunction (Prod s) (Reader s) where
--   counit (Prod (Reader f, s)) = f s
--   unit a = Reader (\s -> Prod (a, s))
  
runState :: State s a -> s -> (a, s)
runState (State f) s = f s

-- ssa :: State s (State s a)
-- runState ssa :: s -> (State s a, s)

-- join :: State s (State s a) -> State s a
-- join ssa = State (uncurry runState . runState ssa)
  
main:: IO ()
main = putStrLn "Hello"