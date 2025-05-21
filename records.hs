module Records where

import Data.List (isPrefixOf)

startsWithSymbol :: (String, String, Int) -> Bool
startsWithSymbol (name, symbol, _) = isPrefixOf symbol name

data Element = Element
  { name :: String,
    symbol :: String,
    atomicNumber :: Int
  }

tupleToElem :: (String, String, Int) -> Element
tupleToElem (n, s, a) = Element {name = n, symbol = s, atomicNumber = a}

elemToTuple :: Element -> (String, String, Int)
elemToTuple e = (name e, symbol e, atomicNumber e)

startsWithSymbol' :: Element -> Bool
-- startsWithSymbol' e = isPrefixOf (symbol e) (name e)
startsWithSymbol' e = symbol e `isPrefixOf` name e
