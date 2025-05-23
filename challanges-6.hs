{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
module Challenges6 where

-- 1. Show the isomorphism between Maybe a and Either () a.
maybeToEither :: Maybe a -> Either () a
maybeToEither m =
  case m of
    Nothing -> Left ()
    Just x -> Right x

eitherToMaybe :: Either () a -> Maybe a
eitherToMaybe m =
  case m of
    Left () -> Nothing
    Right x -> Just x

maybeToEither' :: Maybe a -> Either () a
maybeToEither' Nothing = Left ()
maybeToEither' (Just x) = Right x

eitherToMaybe' :: Either () a -> Maybe a
eitherToMaybe' (Left ()) = Nothing
eitherToMaybe' (Right x) = Just x

-- 2. Here’s a sum type defined in Haskell:
data Shape = Circle Float | Rect Float Float | Square Float

area :: Shape -> Float
area (Circle r) = pi * r * r
area (Rect d h) = d * h
area (Square d) = d * d

-- Implement Shape in C++ or Java as an interface and create two
-- classes: Circle and Rect. Implement area as a virtual function.
-- see shape.cpp and shape.ts

-- 3. Continuing with the previous example: We can easily add a new
-- function circ that calculates the circumference of a Shape. We
-- can do it without touching the definition of Shape:
circ :: Shape -> Float
circ (Circle r) = 2.0 * pi * r
circ (Rect d h) = 2.0 * (d + h)
circ (Square d) = 4.0 * d

-- 4. Continuing further: Add a new shape, Square, to Shape and make
-- all the necessary updates. What code did you have to touch in
-- Haskell vs. C++ or Java? (Even if you’re not a Haskell programmer,
-- the modifications should be pretty obvious.)

-- 5. Show that 𝑎 + 𝑎 = 2 × 𝑎 holds for types (up to isomorphism). Remember
-- that 2 corresponds to Bool, according to our translation
-- table.

proof :: Either a a -> (Bool, a)
proof (Left x) = (False, x)
proof (Right x) = (True, x)

inverse_proof :: (Bool, a) -> Either a a
inverse_proof (False, x) = Left x
inverse_proof (True, x) = Right x
