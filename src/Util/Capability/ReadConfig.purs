module Util.Capability.ReadConfig where

import Proem

import Config.Config (Config)

class Monad m <= ReadConfig m where
  readConfig :: m Config