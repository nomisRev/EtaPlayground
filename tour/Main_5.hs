{-# LANGUAGE RankNTypes #-}

data List a = Nil | Cons a (List a)
  deriving (Show, Eq)

myList :: List Int
myList = Cons 1 $ Cons 2 Nil

customShow :: List Int -> String
customShow Nil = ""
customShow (Cons head tail) =
  if(tail == Nil)
  then show head
  else show head ++ ", " ++ customShow tail

join :: List Int -> String
join list = "[" ++ customShow list ++ "]"

{-
  Functor<List>#map definition
  `forall a b.` may be ommitted  (according to Eta tour it often is!). transform :: (a -> b) -> List a -> List b

-}
transform :: forall a b. (a -> b) -> List a -> List b
transform _ Nil = Nil
transform f (Cons head tail)
  = Cons (f head) $ transform f tail

inc :: Int -> Int
inc = \x -> x + 1

main :: IO()
main = do
  putStrLn $ join myList
  putStrLn $ join Nil
  putStrLn $ join $ transform inc myList
  putStrLn $ 