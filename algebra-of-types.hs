module Algebra where
  
prodToSum :: (a, Either b c) -> Either (a, b) (a, c)
prodToSum (x, e) =
  case e of
    Left y -> Left (x, y)
    Right z -> Right (x, z)
    
sumToProd :: Either (a, b) (a, c) -> (a, Either b c) 
sumToProd e =
  case e of
    Left (x, y) -> (x, Left y)
    Right (x, z) -> (x, Right z)
    
prod1 :: (Int, Either String Float)
prod1 = (2, Left "Hi")
