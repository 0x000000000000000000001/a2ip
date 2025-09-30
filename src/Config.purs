module Config
  ( Env(..)
  , Config
  , defaultConfig
  )
  where

import Prelude

foreign import assetsBaseUrl :: String
foreign import dev :: Boolean
foreign import env :: Env

data Env = Dev | Test | Stage | Prod

type Config = 
  { assetBaseUrl :: String
  , imageBaseUrl :: String
  , dev :: Boolean
  , env :: Env
  }

assetBaseUrl :: String
assetBaseUrl = assetsBaseUrl <> "asset/"

defaultConfig :: Config
defaultConfig = 
  { assetBaseUrl
  , imageBaseUrl: assetBaseUrl <> "image/"
  , dev
  , env
  }