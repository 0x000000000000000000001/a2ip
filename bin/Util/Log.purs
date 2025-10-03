module Bin.Util.Log
  ( CliColor(..)
  , ansiColorCode
  , colorize
  , debug
  , debugShow
  , error
  , errorShow
  , info
  , infoShow
  , logShow
  , runBinAff
  , success
  , successShow
  , warn
  , warnShow
  )
  where

import Prelude

import CSS (color)
import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, runAff_)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console as Console
import Effect.Exception (Error)

data CliColor = Red | Green | Yellow | Blue | Grey | Reset

ansiColorCode :: CliColor -> String
ansiColorCode Red = "\x1b[31m"
ansiColorCode Green = "\x1b[32m"
ansiColorCode Yellow = "\x1b[33m"
ansiColorCode Blue = "\x1b[34m"
ansiColorCode Reset = "\x1b[0m"
ansiColorCode Grey = "\x1b[90m"

colorize :: CliColor -> String -> String
colorize c s = ansiColorCode c <> s <> ansiColorCode Reset

runBinAff :: Aff Unit -> Effect Unit
runBinAff action = runAff_ handleResult action
  where
  handleResult :: Either Error Unit -> Effect Unit
  handleResult (Left error) = Console.error $ "❌ Fatal error: " <> show error
  handleResult (Right _) = pure unit

log :: forall m. MonadEffect m => String -> m Unit
log = liftEffect <<< Console.log

logShow :: forall m a. MonadEffect m => Show a => a -> m Unit
logShow = log <<< show

debug :: forall m. MonadEffect m => String -> m Unit
debug = liftEffect <<< Console.debug <<< ((colorize Grey "🪲 [debug] ") <> _)

debugShow :: forall m a. MonadEffect m => Show a => a -> m Unit
debugShow = debug <<< show

info :: forall m. MonadEffect m => String -> m Unit
info = liftEffect <<< Console.info <<< ((colorize Blue "ℹ️ [info] ") <> _)

infoShow :: forall m a. MonadEffect m => Show a => a -> m Unit
infoShow = info <<< show

success :: forall m. MonadEffect m => String -> m Unit
success = liftEffect <<< Console.log <<< ((colorize Green "✅[success] ") <> _)

successShow :: forall m a. MonadEffect m => Show a => a -> m Unit
successShow = success <<< show

error :: forall m. MonadEffect m => String -> m Unit
error = liftEffect <<< Console.error <<< ((colorize Red "❌[error] ") <> _)

errorShow :: forall m a. MonadEffect m => Show a => a -> m Unit
errorShow = error <<< show

warn :: forall m. MonadEffect m => String -> m Unit
warn = liftEffect <<< Console.warn <<< ((colorize Yellow "⚠️ [warning] ") <> _)

warnShow :: forall m a. MonadEffect m => Show a => a -> m Unit
warnShow = warn <<< show
