module Main where

-- instance Monad Maybe where
--   Nothing >>= k = Nothing
--   Just a >>= k = k a
--   return a = Just a

main :: IO ()
main = do
  putStrLn $ "Result: " ++ "done"
