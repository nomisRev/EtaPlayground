
import Text.Read

-- Mappable (Functor)           Eta seems to name design patterns which use typeclasses. The design pattern here is caleld Mappable while the typeclass is called Functor.

data MMaybe a = MJust a | MNothing
  deriving (Show, Eq)

headMaybe :: [a] -> MMaybe a --You can prefix with file name apperently..
headMaybe [] = MNothing
headMaybe (x : xs) = MJust x

maybeLength :: Maybe String -> Maybe Int --Quite boilerplatey just to get length. We can refactor using `map`
maybeLength a = case a of
  Just str -> Just $ length str
  Nothing -> Nothing

mapMaybe :: (a -> b) -> MMaybe a -> MMaybe b --Map implementation. 
mapMaybe f ma = case ma of
  MJust a -> MJust $ f a
  MNothing -> MNothing

maybeLength2 :: MMaybe String -> MMaybe Int
maybeLength2 a = mapMaybe length a

instance Functor MMaybe where
  --fmap :: (a -> b) -> MMaybe a -> Maybe b --Eta says writing signature is considered good practice so enable {-# LANGUAGE InstanceSigs #-} globablly somehow
  fmap f ma = mapMaybe f ma

-- Applyable (Applicative)
maybeAdd :: Maybe Int -> Maybe Int -> Maybe Int --Actual logic is burried in pattern matching code...
maybeAdd mx my = case mx of 
  Nothing -> Nothing
  Just x -> case my of
    Nothing -> Nothing
    Just y -> Just $ x + y

maybeAp :: MMaybe (a -> b) -> MMaybe a -> MMaybe b
maybeAp mAp ma = case mAp of 
  MNothing -> MNothing
  MJust f -> case ma of
    MNothing -> MNothing
    MJust a -> MJust $ f a

{-
  (+) :: Int -> Int -> Int   ==> Int -> (Int -> Int)
  fmap :: (a -> b) -> Maybe a -> Maybe b  ==>
    (Int -> (Int -> Int)) -> Maybe Int -> Maybe (Int -> Int) This is exactly the signature we need for AP. This works only because (+) is curried.
-}
maybeAdd2 :: MMaybe Int -> MMaybe Int -> MMaybe Int
maybeAdd2 ma mb = (+) `fmap` ma `maybeAp` mb --Infix notation by using backticks (`)
             -- = maybeAp (fmap (+) ma) mb.

instance Applicative MMaybe where
  pure a = MJust a
  (<*>) mAp ma =  maybeAp mAp ma

maybeAdd3 :: MMaybe Int -> MMaybe Int -> MMaybe Int
maybeAdd3 ma mb = (+) <$> ma <*> mb

add3 :: Int -> Int -> Int -> Int
add3 x y z = x + y + z

-- Sequenceable (Monad)
readInt :: String -> Maybe Int
readInt = readMaybe

addNonNegative :: Int -> Maybe Int
addNonNegative n
  | n >= 0 = Just $ n + 100
  | otherwise = Nothing

addStringInt :: String -> Maybe Int               -- Again a lot of boilerplate just to chain 2 functions.. More pattern matching...
addStringInt str = case readMaybe str of
  Nothing -> Nothing
  Just int -> addNonNegative int

bindMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b   -- FlatMap / Bind
bindMaybe ma f = case ma of
  Just a ->  f a
  Nothing -> Nothing

addStringInt2 :: String -> Maybe Int
addStringInt2 str = bindMaybe (readInt str) addNonNegative

addStringInt3 :: String -> Maybe Int
addStringInt3 str = (readInt str) >>= addNonNegative --`>>=` is flatMap

addStringInt4 :: String -> Maybe Int --Exactly the same as `for` in Scala.
addStringInt4 str = do           
  int <- readInt str
  addNonNegative int

main :: IO()
main = do
  print $ headMaybe [1, 5.. 10]
  print $ headMaybe ([] :: [Int]) --as [Int]
  print $ maybeLength $ Just "Hello World!"
  print $ maybeLength2 $ MJust "Hello World!!"
  print $ fmap length $ MJust "Hello World!!!" --With our Functor instance defined we can use `fmap` globally
  print $ maybeAdd (Just 1) (Just 2)
  print $ maybeAp (fmap (+) (MJust 2)) (MJust 2)
  let mx = MJust 1
      my = MJust 2
  print $ maybeAdd3 mx my
  print $ add3 <$> mx <*> my <*> pure 3 -- Take add3 and map it with `mx` => Maybe (Int -> Int -> Int), apply `my` and apply `pure 3`. fmap + AP is used for partial application of functions within context of F.
  print $ addStringInt "123"
  print $ addStringInt "12a"
  print $ addStringInt3 "124"
  print $ addStringInt4 "125"









