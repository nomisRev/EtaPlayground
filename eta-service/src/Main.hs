module Main where

--Import https://haskell-servant.readthedocs.io/
import Servant
import Servant.Server
import Data.Aeson
import Network.Wai.Servlet.Handler.Jetty

--Import end points
import Fib
import Hello

--Our API is a composition of all endpoints
type API = Fib :<|> Hello

--A server defintion defines an API and the handlers of all its endpoints
server :: Server API
server = fibHandler :<|> hello

app :: Application
app = serve (Proxy :: Proxy API) server

main :: IO ()
main = run 9000 (app)
