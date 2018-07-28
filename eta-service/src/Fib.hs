module Fib where

import Servant
import Data.Aeson

type Fib = "fibonacci" :> Capture "n" Int :> Get '[JSON] Value

fib :: Int -> Int
fib 0 = 1
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

fibHandler :: Int -> Handler Value
fibHandler n
    | n >= 0 = return $ object ["n" .= n, "fib" .= fib n]
    | otherwise = throwError $ err412 { errBody = "Precondition Failed: n > 0" }
    