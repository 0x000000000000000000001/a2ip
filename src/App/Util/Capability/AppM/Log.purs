module App.Util.Capability.AppM.Log (AppM, runAppM) where

import Proem

import Config.Config (Config)
import Control.Monad.Error.Class (class MonadError, class MonadThrow)
import Control.Monad.Reader (class MonadAsk, ReaderT, runReaderT)
import Effect.Aff (Aff)
import Effect.Aff.Class (class MonadAff)
import Effect.Class (class MonadEffect)
import Effect.Exception (Error)

instance logAppM :: Log AppM where 
  log level message = 
    let msg = show level <> ": " <> message
    in case level of 
      Debug -> Console.debug msg
      Info -> Console.info msg
      Warn -> Console.warn msg
      Error -> Console.error msg
  logShow level a = log level (show a)
  info msg = log Info msg
  infoShow a = logShow Info a
  debug msg = log Debug msg
  debugShow a = logShow Debug a
  warn msg = log Warn msg
  warnShow a = logShow Warn a
  error msg = log Error msg
  errorShow a = logShow Error a
