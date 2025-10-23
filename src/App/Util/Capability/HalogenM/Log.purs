module App.Util.Capability.HalogenM.Log (AppM, runAppM) where

import Proem

import Config.Config (Config)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Control.Monad.Reader (class MonadAsk, ReaderT, runReaderT)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Effect.Exception (Error)

instance logHalogenM :: Log m => Log (HalogenM state action slots output m) where
  log level message = lift $ log level message
  logShow level a = lift $ logShow level a
  info message = lift $ info message
  infoShow a = lift $ infoShow a
  debug message = lift $ debug message
  debugShow a = lift $ debugShow a
  warn message = lift $ warn message
  warnShow a = lift $ warnShow a
  error message = lift $ error message
  errorShow a = lift $ errorShow a
