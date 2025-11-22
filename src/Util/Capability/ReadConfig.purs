module Util.Capability.ReadConfig where

import Proem

import Meta.Config.Config (Config)
import Control.Monad.Reader (lift)
import Halogen (HalogenM)

class Monad m <= ReadConfig m where
  readConfig :: m Config

instance readConfigHalogenM :: ReadConfig m => ReadConfig (HalogenM state action slots output m) where
  readConfig = lift readConfig