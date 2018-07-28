module Main where -- May be ommited for `Main.eta` / `Main.hs`

import Text.Printf hiding(printf)
import qualified Text.Printf as P


main :: IO ()
main = do
    putStrLn "\nBunch of exercices that run in sequence using dot notation\n"

    firstEx
    putStrLn ""

    sndEx
    putStrLn ""

    trdEx
    putStrLn ""

    fourthEx
    putStrLn ""

    putStrLn "Cya!"


fullName :: String              -- Declare a binding of `fullName` of type `String`
fullName = "Simon Vergauwen"    -- Bind binding to value

powerLevel :: Int
powerLevel = 10000

firstEx :: IO()
firstEx = putStrLn $ fullName
            ++ " has power level "
            ++ show powerLevel ++ "!"


printf :: Int   -- Clashes with `Text.Printf` we can hide printf of `Text.Printf`
printf = 1      -- Or we can import it as a qualifie import

sndEx :: IO()
sndEx = do
    P.printf  "Hello %s! Your score is 100." "Simon Vergauwen"
    putStrLn ""


add :: Int -> Int -> Int -- Can be omitted but is considered bad practice for public APIs
add x y = x + y          -- Inferred type is `add :: Num a => a -> a -> a`

trdEx :: IO()
trdEx = putStrLn $ "123 + 321 = " ++ show (add 123 321)

string :: String
string = "string"

bool :: Bool
bool = True

int :: Int
int = 42

double :: Double
double = 32.0

pair :: (Float, Integer)
pair = (3.0, 9)

list :: [Int]
list = [1, 2, 3, 4, 5]

justChar :: Maybe Char
justChar = Just 'a'

add3 :: Int -> Int
add3 = \x -> x + 3 --named params in lambda?

fourthEx :: IO()
fourthEx = print (string, bool, int, double, pair, list, justChar, add3 4)
