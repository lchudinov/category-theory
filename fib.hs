module Main where

fib :: Int -> Int
fib 0 = 1
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

k = 12

main :: IO ()
main = do
  putStrLn $ "fib " ++ show k ++ " = " ++ show (fib k) 