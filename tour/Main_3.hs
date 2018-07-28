{-# LANGUAGE RecordWildCards #-}
import Numeric

{-
	Data definitions
-}

 {-
 First declares `type constructor` `Pair` than define `data constructor` `Tuple2`.
 Doesn't have to be same but probably good idea to always have it same. Must start with capital letter
 -}
data Pair = Tuple2 Int Int deriving Show -- You can also just derive instances

myPair :: Pair
myPair = Tuple2 (-1) (-2)

{-
    With `case _ of` you can CASE match over different data constructors (more useful with sum types).
    Don't confuse `case expression` with pattern matching. Case matching is what exists in Kotlin.
-}
showPair :: Pair -> String
showPair p = case p of
    Tuple2 x y -> "(" ++ show x ++ "," ++ show y ++ ")"
    --They seem to call `show` an overloaded function. I guess in Haskell they use that term for typeclass syntax.

showPair2 :: Pair -> String
showPair2 (Tuple2 x y) =                  -- Pattern matching - also done on data constructor not type constructor
    "(" ++ show x ++ "," ++ show y ++ ")"

transformPair1 :: Pair -> Pair
transformPair1 (Tuple2 x y) = Tuple2 (x + 1) (y + 1)

transformPair2 :: Pair -> Pair
transformPair2 (Tuple2 x y) =
    let x' = x + 1              --let can be used to create local bindings
        y' = y + 1
    in Tuple2 x' y'

transformPair3 :: Pair -> Pair
transformPair3 (Tuple2 x y) = Tuple2 x' y' -- where expressions are an alternative to let to make code more readable
  where x' = x + 2
        y' = y + 2

absInt :: Int -> Int
absInt n = if n > 0
    then n
    else -n

absGuard :: Int -> Int
absGuard n
  | n >= 0 = n
  | otherwise = -n --otherwhise is an alias for True imported from Prelude. Genius!

absPair :: Pair -> Pair
absPair (Tuple2 x y) = Tuple2 (absInt x) (absGuard y)

data Color = Red | Blue | Green | Color Int Int Int

colorToString :: Color -> String
colorToString Red = "red"
colorToString Blue = "blue"
colorToString Green = "green"
colorToString (Color r g b) =
  "#" ++ pad 6 (showHex (r * 256  * 256 + g * 256 + b) "")
  where pad n str = replicate (n - length str) '0' ++ str

isGreen :: Color -> Bool
isGreen n = case n of
  Green -> True
  _ -> False

equalsColor :: Color -> Color -> Bool
equalsColor (Color r1 g1 b1) (Color r2 g2 b2) = 
  (r1 == r2) && (g1 == g2) && (b1 == b2)
equalsColor Red Red = True
equalsColor Blue Blue = True
equalsColor Green Green = True
equalsColor _ _ = False

factorial :: Integer -> Integer -- Integer is a special case we can pattern match on
factorial 0 = 1
factorial n = n * factorial (n - 1)

data NamedPair = NamedPair { pairX :: Int
                           , pairY :: Int }

myNamedPair :: NamedPair
myNamedPair = NamedPair { pairX = 1
                        , pairY = 2 }

printNamedPair :: NamedPair -> String
printNamedPair pair =
  "(" ++ show (pairX pair) ++
  ", " ++ show (pairY pair) ++ ")"

printNamedPair2 :: NamedPair -> String
printNamedPair2 NamedPair {..} =
  "(" ++ show pairX ++
  ", " ++ show pairY ++ ")"

namedLocalBindings :: NamedPair -> String
namedLocalBindings NamedPair { pairX = x, pairY = y } =
  "(" ++ show x ++
  ", " ++ show y ++ ")"
 
main :: IO()
main =  do
  putStrLn "Unable to print Pair yet!!" --We have no derived instances yet!
  putStrLn $ "showPair = " ++ showPair myPair
  putStrLn $ "show = " ++ show myPair
  putStrLn $ "showPair2 = " ++ showPair2 myPair
  putStrLn $ show (transformPair1 myPair) ++ " = " ++ show (transformPair2 myPair)
  putStrLn $ show (transformPair3 myPair)
  putStrLn $ "abs " ++ show myPair ++" = " ++ show (absPair myPair)
  putStrLn $ colorToString Red
  putStrLn $ colorToString (Color 12 14 255)
  putStrLn $ show (isGreen Green)
  putStrLn $ show (equalsColor (Color 12 14 255) (Color 12 14 255))
  putStrLn $ "factorial(20) = " ++ show (factorial 20)
  putStrLn $ "myNamedPair = " ++ show (printNamedPair myNamedPair)
  putStrLn $ "namedLocalBindings = " ++ show (namedLocalBindings myNamedPair)