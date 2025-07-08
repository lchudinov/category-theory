module CurryHoward where

-- Void corresponds to false
-- () corresponds to true
-- Product types correspond to logical conjunction
-- Sum types - to logical disjunction
-- function type corresponds to logical implication

-- Curry Howard isomorphism - every type can be interpreted as a proposition.
-- Such a proposition is considered true if the type is inhabited and false if isn't.
-- A logical implication is true if the function type is inhabited,
-- which means that there exists a function of that type. An implementation of a function is
-- therefore a proof of a theorem. Writing programs is equivalent to proving theorems.

eval :: ((a -> b), a) -> b -- ((a ==> b) /\ a) ==> b - modus ponens
eval (f, x) = f x

newtype Void = Void Void
absurd (Void a) = absurd a