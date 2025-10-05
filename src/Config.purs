module Config
  ( Env(..)
  , Config
  , config
  )
  where

import Prelude

foreign import _config :: 
  { rootDir :: String
  , env :: String
  }

data Env = Dev | Test | Stage | Prod

derive instance eqEnv :: Eq Env

env :: Env
env = 
  case _config.env of
    "dev" -> Dev
    "test" -> Test
    "stage" -> Stage
    "prod" -> Prod
    _ -> Dev

type Config = 
  { rootDir :: String 
  , assetBaseUrl :: String
  , imageBaseUrl :: String
  , dev :: Boolean
  , env :: Env
  }

assetBaseUrl :: String
assetBaseUrl = _config.rootDir <> "asset/"

config :: Config
config = 
  { rootDir: _config.rootDir
  , assetBaseUrl
  , imageBaseUrl: assetBaseUrl <> "image/"
  , dev: Dev == env
  , env
  }