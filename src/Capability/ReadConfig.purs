module Capability.ReadConfig where

import Prelude

import AppM (AppM)
import Config (Config)
import Control.Monad.Reader.Class (class MonadAsk, ask)
import Control.Monad.Trans.Class (lift)
import Halogen (HalogenM)

class Monad m <= ReadConfig m where
  readConfig :: m Config

instance readConfigAppM :: MonadAsk Config AppM => ReadConfig AppM where
  readConfig = ask

instance readConfigHalogenM :: ReadConfig m => ReadConfig (HalogenM state action slots output m) where
  readConfig = lift readConfig

getAssetUrl :: forall m. ReadConfig m => String -> m String
getAssetUrl filePath = do
  config <- readConfig
  let baseUrl = config.assetBaseUrl
  pure $ baseUrl <> filePath

getImageUrl :: forall m. ReadConfig m => String -> m String
getImageUrl filePath = do
  config <- readConfig
  let baseUrl = config.imageBaseUrl
  pure $ baseUrl <> filePath
