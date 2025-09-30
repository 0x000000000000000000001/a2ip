module Config where

import Data.Maybe (Maybe)

foreign import imageBaseUrl :: String
foreign import dev :: Boolean

type Config = 
  { imageBaseUrl :: String
  , dev :: Boolean
  }

defaultConfig :: Config
defaultConfig = 
  { imageBaseUrl
  , dev
  }