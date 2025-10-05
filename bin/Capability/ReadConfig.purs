module Bin.Capability.ReadConfig where

import Prelude

import Bin.Capability.BinM (BinM)
import Config.Config (Config)
import Control.Monad.Reader.Class (class MonadAsk, ask)

class Monad m <= ReadConfig m where
  readConfig :: m Config

instance readConfigBinM :: MonadAsk Config BinM => ReadConfig BinM where
  readConfig = ask