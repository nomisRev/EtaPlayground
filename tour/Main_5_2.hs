--TYPECLASSES WOOHOOO

data Pair = Pair Int Int
instance Show Pair where
  -- show :: Pair -> String --To add this we need to add {-# LANGUAGE InstanceSigs #-}
  show (Pair x y) = "(" ++ show x ++ ", " ++ show y ++ ")"


{-
  Higher-order functions that take other functions as param.
  Also called *function transformers* since they take a function and produce a new function.
  If we apply parantheses it becomes clear.
-}
main :: IO()
main = do
  let xs = [1..20]
  print $ (map (+ 100)) xs --(+ 100) returns a function (Int -> Int). map(Int -> Int) returns List Int -> List Int which we then apply to xs
  print $ filter (> 10) xs
  print $ any (== 10) xs
  print $ all (> 10) xs
  print $ Pair 1 2
