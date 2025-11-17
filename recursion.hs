module Recursion where
import Algebra (RingF)

data Expr = RZero
          | ROne
          | RAdd Expr Expr
          | RMul Expr Expr
          | RNeg Expr
          
evalZ :: Expr -> Integer
evalZ RZero = 0
evalZ ROne = 1
evalZ (RAdd e1 e2) = evalZ e1 + evalZ e2
evalZ (RMul e1 e2) = evalZ e1 * evalZ e2
evalZ (RNeg e) = -(evalZ e)

type RingF1 a = RingF (RingF a)
type RingF2 a = RingF (RingF1 a)

newtype Fix f = Fix (f (Fix f))

-- Fix :: f (Fix f) -> Fix f

unFix :: Fix f -> f (Fix f)
unFix (Fix x) = x
