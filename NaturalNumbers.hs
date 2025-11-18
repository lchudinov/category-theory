module NaturalNumbers where

data NatF a = ZeroF | SuccF a

data Nat = Zero | Succ Nat