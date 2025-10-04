module Config
  ( Env(..)
  , Config
  , defaultConfig
  )
  where

import Prelude

foreign import lookupEnv :: String -> String

data Env = Dev | Test | Stage | Prod

derive instance eqEnv :: Eq Env

env :: Env
env = 
  let rawEnv = lookupEnv "ENV" in
  case rawEnv of
    "dev" -> Dev
    "test" -> Test
    "stage" -> Stage
    "prod" -> Prod
    _ -> Dev

type Config = 
  { assetBaseUrl :: String
  , imageBaseUrl :: String
  , dev :: Boolean
  , env :: Env
  }

assetBaseUrl :: String
assetBaseUrl = lookupEnv "ROOT_DIR" <> "asset/"

defaultConfig :: Config
defaultConfig = 
  { assetBaseUrl
  , imageBaseUrl: assetBaseUrl <> "image/"
  , dev: Dev == env
  , env
  }