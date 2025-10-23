module Component.Util.Capability.ReadConfig where

import Proem

import Component.Util.Capability.AppM (AppM)
import Config.Config (Config)
import Control.Monad.Reader.Class (class MonadAsk, ask)
import Control.Monad.Trans.Class (lift)
import Halogen (HalogenM)

class Monad m <= ReadConfig m where
  readConfig :: m Config

instance readConfigAppM :: MonadAsk Config AppM => ReadConfig AppM where
  readConfig = ask

instance readConfigHalogenM :: ReadConfig m => ReadConfig (HalogenM state action slots output m) where
  readConfig = lift readConfig