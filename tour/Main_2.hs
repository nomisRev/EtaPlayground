main :: IO()
main = do
    -- arithmeticOps
    -- logicOps
    listOps

{-
    Program that demonstartes some of the functions defined for `[]`.
    This is also a multiline comment :D
-}
listOps :: IO()
listOps = do
    print $ [1, 2, 3, 4] ++ [5, 6, 7, 8]
    print $ "hello" ++ " " ++ "world" --String is equivalent of [Char]
    print $ ['w', 'h'] ++ ['a', 't']
    print $ null [] --null is a function to check emptyiness of value. (i.e. Foldable derived function that checks if no values present)
    print $ null ""
    print $ length [32, 43, 120]
    print $ take 5 [1,5..100]
    print $ drop 5 [1,2..10]
    print $ replicate 4 "AB"
    print $ head [1..10]
    print $ tail [1..10]
    print $ init [1..10]
    print $ last [1..10]
    print $ safeHead list

list :: [Int] --Need to declare here
list = []

safeHead :: [a] -> Maybe a --Pattern matching on list to get head in a safe manner using Maybe
safeHead [] = Nothing
safeHead (x:xs) = Just x


logicOps :: IO()
logicOps = do
    putStrLn $ "True && True = " ++ show (True && True)
    putStrLn $ "True && False = " ++ show (True && False)
    putStrLn $ "False || True = " ++ show (False || True)
    putStrLn $ "not False = " ++ show (not False)
    putStrLn $ "not (False && False) = " ++ show (not (False && False))
    putStrLn $ "7 == 7 = " ++ show (7 == 7)
    putStrLn $ "7 == 6 = " ++ show (7 == 6)
    putStrLn $ "7 > 6 = " ++ show (7 > 6)
    putStrLn $ "7 < 6 = " ++ show (7 < 6)
    putStrLn $ "7 /= 6 = " ++ show (7 /= 6)
    putStrLn $ "7 /= 7 = " ++ show (7 /= 7)
    putStrLn $ "7 <= 7 = " ++ show (7 <= 7)
    putStrLn $ "7 <= 6 = " ++ show (7 <= 6)
    putStrLn $ "compare 7 6 = " ++ show (compare 7 6)

arithmeticOps :: IO()
arithmeticOps = do
    putStrLn $ "2 + 3 = " ++ show (2 + 3)
    putStrLn $ "2 - 3 = " ++ show (2 - 3)
    putStrLn $ "(5 * 3) - 10 = " ++ show ((5 * 3) - 10)
    putStrLn $ "5 * 3  - 10 = " ++ show (5 * 3 - 10)
    putStrLn $ "5 * (3 - 10) = " ++ show(5 * (3 - 10))
    putStrLn $ "quot 77 4 = " ++ show(quot 77 4)
    putStrLn $ "rem 77 4 = " ++ show(rem 77 4)
    putStrLn $ "min 6 9 = " ++ show(min 6 9)
    putStrLn $ "max 7 10 = " ++ show(max 7 10)
    putStrLn $ "succ 100 = " ++ show(succ 100)
    putStrLn $ "succ 113 + max 5 74 + 1 = " ++ show(succ 113 + max 5 74 + 1)