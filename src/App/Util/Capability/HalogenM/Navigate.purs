module App.Util.Capability.HalogenM.Navigate (AppM, runAppM) where

import Proem

import Config.Config (Config)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Control.Monad.Reader (class MonadAsk, ReaderT, runReaderT)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Effect.Exception (Error)

instance navigateHalogenM :: Navigate m => Navigate (HalogenM state action slots output m) where
  navigate = lift ◁ navigate
