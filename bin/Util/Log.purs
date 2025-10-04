module Bin.Util.Log
  ( colorize
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

import Ansi.Codes (Color, EscapeCode(..), GraphicsParam(..), escapeCodeToString)
import Data.Either (Either(..))
import Data.List.NonEmpty (singleton)
import Effect (Effect)
import Effect.Aff (Aff, runAff_)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console as Console
import Effect.Exception (Error)

colorize :: Color -> String -> String
colorize c s = 
  escapeCodeToString (Graphics (singleton $ PForeground c)) 
  <> s 
  <> escapeCodeToString (Graphics (singleton Reset))

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

prefixed :: String -> Color -> String -> String -> Boolean -> Boolean -> String
prefixed prefix color emoji msg short colorize_ = 
  emoji 
  <> " " 
  <> (if short then "" else colorize color $ "[" <> prefix <> "] ") 
  <> (if colorize_ then colorize color msg else msg)

newline :: forall m. MonadEffect m => m Unit
newline = log ""