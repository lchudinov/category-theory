module ClownsJokers where
  
data Expr = Val Int | Add Expr Expr

-- eval :: Expr -> Int
-- eval (Val i) = i
-- eval (Add e1 e2) = eval e1 + eval e2

type Stack = [Either Expr Int]

eval :: Expr -> Int
eval e = load e []

load :: Expr -> Stack -> Int
load (Val i) stk = unload i stk
load (Add e1 e2) stk = load e1 (Left e2: stk)

unload :: Int -> Stack -> Int
unload v [] = v
unload v1 (Left e2: stk) = load e2 (Right v1: stk)
unload v2 (Right v1: stk) = unload (v1 + v2) stk

-- Вычислим: Add (Val 2) (Add (Val 3) (Val 4))

-- Постфиксный порядок (анализ стека):
-- load Add(2, Add(3, 4)) []
-- → load 2 [Left Add(3, 4)]
-- → unload 2 [Left Add(3, 4)]
-- → load Add(3, 4) [Right 2]
-- → load 3 [Left 4, Right 2]
-- → unload 3 [Left 4, Right 2]
-- → load 4 [Right 3, Right 2]
-- → unload 4 [Right 3, Right 2]
-- → unload (3+4=7) [Right 2]
-- → unload (2+7=9) []

-- Итог: 9
