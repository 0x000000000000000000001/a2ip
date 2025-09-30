module Capability.Config where

import Prelude

import AppM (AppM)
import Config (Config)
import Control.Monad.Trans.Class (lift)
import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Effect.Class.Console as Console
import Halogen (HalogenM)

class Monad m <= ReadConfig m where
  readConfig :: m Config

instance readConfigAppM :: ReadConfig AppM where
  readConfig = ask

instance readConfigHalogenM :: ReadConfig m => ReadConfig (H.HalogenM s a slots o m) where
  readConfig = H.lift readConfig

assetUrl :: forall m. ReadConfig m => String -> m String
assetUrl filePath = do
  config <- readConfig
  let baseUrl = config.assetBaseUrl
  pure $ baseUrl <> filePath
