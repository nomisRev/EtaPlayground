{-# OPTIONS_GHC -fwarn-incomplete-patterns #-} --It seems you can only warn for exhaustiveness. Shame.. look into this more.

addOne :: Int -> Int --Eta docs state "A function is *a value* that takes another value as input and ouputs a value.". Everything is a value! :)
addOne = \x -> x + 1 --this is a function literal or lambda expression by using `\`

addTwo :: (->) Int Int -- `->` is an infix type constructor. Like in Scalaz `\/` or `Refined`
addTwo x = x + 2

addThree :: Int -> Int
addThree = (add 3)   --Partial application of curried signature of `add`

addSix :: Int -> Int
addSix = addThree . addTwo . addOne -- Composition reads from right to left. addOne is run first

add :: Int -> Int -> Int
add = \x y -> x + y -- Function literal with multiple arguments

mutliply:: Int -> Int -> Int
mutliply = \x y -> x * y

subs :: Int -> Int -> Int
subs = \x y -> x - y

main :: IO()
main = do
  print $ addOne 5
  print $ addTwo 5
  print $ add 3 5
  print $ addThree 5
  print $ addSix 5
  print $ (subs 4 . mutliply 2 . add 3) 5 --Do in place partial application to make (subFour . multTwo . addThree).
  print $ subs 4 . mutliply 2 . add 3 $ 5 --`$` is plain old function application but it removes the need for ()
  print((subs 4 . mutliply 2 . add 3) 5) --As you can see without `$` we need to wrap everything in `()`
  print $ first myIntList
  print $ join myIntList
  print $ maximumIntList testIntList == 100 
  print $ sumIntList testIntList == 438

{-
 Recursion is about breaking down your problem into smaller pieces. We can apply the same technique to data structures
 To represent a variable # of elements we define what a type that can be either Empty or a value + type. (Think LinkedList)
-}
data IntList = Empty | AddElement Int IntList

myIntList :: IntList
myIntList = AddElement 1 (AddElement 2 Empty)

first :: IntList -> String    --Cannot believe how simple and straight forward pattern matching is in Haskell.
first Empty = ""
first (AddElement int _) = show int 

isEmpty :: IntList -> Bool
isEmpty Empty = True
isEmpty _ = False

join :: IntList -> String
join Empty = ""
join (AddElement head tail) =
  show head ++
  if(isEmpty tail) then "" else ", " ++
  join tail

sumIntList :: IntList -> Int
sumIntList Empty = 0
sumIntList (AddElement head tail) = head + sumIntList tail

maximumIntList :: IntList -> Int
maximumIntList Empty = 0
maximumIntList (AddElement head tail) =
  if (head > y')
  then head
  else y'
  where y' = maximumIntList tail

testIntList :: IntList
testIntList = AddElement 20  $ AddElement 30 --You can also use `$` to chain nested constructors 
            $ AddElement 23  $ AddElement 82
            $ AddElement 100 $ AddElement 88
            $ AddElement 95 Empty


