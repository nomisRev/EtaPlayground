{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}

module Hello where

import GHC.Generics
import Servant
import Data.Aeson

type Hello = "hello2" :> QueryParam "name" String :> Get '[JSON] HelloMessage

newtype HelloMessage = HelloMessage { msg :: String }
  deriving (Generic, ToJSON)

hello :: Maybe String -> Handler HelloMessage
hello Nothing = throwError $ err412 { errBody = "You didn't tell me your name" }
hello (Just name) = return . HelloMessage $ "Hello, " ++ name
