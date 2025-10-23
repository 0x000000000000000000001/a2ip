module Bin.Util.Capability.ReadConfig where

import Proem

import Bin.Util.Capability.BinM (BinM)
import Bin.Util.Exit (exitError, exitSuccess)
import Util.Capability.ReadConfig (class ReadConfig)
import Config.Config (Config)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Control.Monad.Reader (class MonadAsk, ReaderT, runReaderT)
import Control.Monad.Reader.Class (ask)
import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, runAff_)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Effect.Console as Console
import Effect.Exception (Error)

instance readConfigBinM :: MonadAsk Config BinM => ReadConfig BinM where
  readConfig = ask