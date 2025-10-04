module Bin.Util.Log
  ( CliColor(..)
  , ansiColorCode
  , colorize
  , log
  , logAfterNewline
  , logShow
  , logShowAfterNewline
  , newline
  , prefixed
  , runBinAff
  , write
  )
  where

import Prelude

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
  handleResult (Left e) = Console.error $ "🧨 Fatal error: " <> show e
  handleResult (Right _) = pure unit

foreign import _write :: String -> Effect Unit

write :: forall m. MonadEffect m => String -> m Unit
write = liftEffect <<< _write

log :: forall m. MonadEffect m => String -> m Unit
log = liftEffect <<< Console.log

logAfterNewline :: forall m. MonadEffect m => String -> m Unit
logAfterNewline msg = newline *> log msg

logShow :: forall m a. MonadEffect m => Show a => a -> m Unit
logShow = log <<< show

logShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
logShowAfterNewline = logAfterNewline <<< show

prefixed :: String -> CliColor -> String -> String -> Boolean -> Boolean -> String
prefixed prefix color emoji msg short colorize_ = 
  emoji 
  <> " " 
  <> (if short then "" else colorize color "[" <> prefix <> "] ") 
  <> (if colorize_ then colorize color msg else msg)

newline :: forall m. MonadEffect m => m Unit
newline = log "\n"