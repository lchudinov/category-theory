module Types where
  
x :: Int
x = 5

y :: Integer
y = 10

f :: Bool -> Bool
f x = undefined

fact n = product [1..n]

-- absurd :: Void -> a
-- Void is not inhabited by any value 

f44 :: () -> Integer
f44 () = 44
-- () is a singleton set which has just one value. In Haskell it's named unit. In C, surprisingly, it is void.

fInt :: Integer -> ()
fInt x = ()

unit :: a -> ()
unit _ = ()

data MyBool = True | False 
-- Two element set
