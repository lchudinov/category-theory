module ContactMod where

data Contact = PhoneNum Int | EmailAddr String

helpdesk :: Contact
helpdesk = PhoneNum 22222

data Either' a b = Left' a | Right' b

factorizer :: (a -> c) -> (b -> c) -> Either' a b -> c
factorizer i j (Left' a) = i a
factorizer i j (Right' b) = j b