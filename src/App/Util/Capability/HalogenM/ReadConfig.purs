module App.Util.Capability.HalogenM.ReadConfig where

import Proem

import Util.Capability.ReadConfig (class ReadConfig)
import App.Util.Capability.AppM.AppM (AppM)
import Config.Config (Config)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Effect.Exception (Error)
import Halogen (HalogenM)
import Control.Monad.Reader.Class (class MonadAsk, ask)
import Control.Monad.Trans.Class (lift)
import Config.Config (Config)
import Control.Monad.Reader.Class (class MonadAsk, ask)
import Control.Monad.Trans.Class (lift)
import Halogen (HalogenM)

instance readConfigHalogenM :: ReadConfig m => ReadConfig (HalogenM state action slots output m) where
  readConfig = lift readConfig
