module SumTypes where
  
data Either a b = Left a | Right b

data OneOfThree a b c = Sinistral a | Medial b | Dextral c

data Maybe' a = Nothing' | Just' a

data NothingType = Nothing''

data JustType a = Just'' a

data Maybe'' a = Either () a

data List a = Nil | Cons a (List a)

maybeTail :: List a -> Maybe (List a)
maybeTail Nil = Nothing
maybeTail (Cons _ t) = Just t
