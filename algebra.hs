module Algebra where
  
type Algebra f a = f a -> a

data MonF a = MEmpty | MAppend a a 

data RingF a = RZero
             | ROne
             | RAdd a a
             | Mul a a
             | RNeg a
             
evalZ :: Algebra RingF Integer
evalZ RZero = 0
evalZ ROne = 1
evalZ (RAdd m n) = m + n
evalZ (RMul m n) = m * n
evalZ (RNeg n) = -n

