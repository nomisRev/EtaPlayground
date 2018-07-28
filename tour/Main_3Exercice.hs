data Pairs = Pair2 Int Int
           | Pair3 Int Int Int
           | Pair4 Int Int Int Int

--Calculates square of all components and adds them up.
sumOfSquaresPairs :: Pairs -> Int
sumOfSquaresPairs (Pair2 a b) = a * a + b * b
sumOfSquaresPairs (Pair3 a b c) = a * a + b * b + c * c
sumOfSquaresPairs (Pair4 a b c d) = a * a + b * b + c * c + d * d

--Returns the maximum of all components
maximumPairs :: Pairs -> Int             --This is ugly! Should be possible with Foldable, Ord.
maximumPairs (Pair2 a b) = max a b        --`def maximum[F : Foldable, A : Order](F[A]): A`
maximumPairs (Pair3 a b c) = max (max a b) c
maximumPairs (Pair4 a b c d) = max (max (max a b) c) d

main :: IO()
main = do
 print $ sumOfSquaresPairs (Pair2 2 3) == 13
 print $ sumOfSquaresPairs (Pair3 1 3 5) == 35
 print $ sumOfSquaresPairs (Pair4 4 100 8 1) == 10081
 print $ maximumPairs (Pair2 72 48) == 72
 print $ maximumPairs (Pair3 1 80 20) == 80
 print $ maximumPairs (Pair4 1000 80 2010 1) == 2010