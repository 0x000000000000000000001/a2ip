module Bin.Util.Log.Log
  ( carriageReturn
  , colorize
  , log
  , logAfterNewline
  , logShow
  , logShowAfterNewline
  , newline
  , prefixed
  , write
  )
  where

import Prelude

import Ansi.Codes (Color, EscapeCode(..), GraphicsParam(..), escapeCodeToString)
import Control.Promise (Promise, toAff)
import Data.List.NonEmpty (singleton)
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Class (liftEffect)
import Effect.Console as Console

colorize :: Color -> String -> String
colorize c s = 
  escapeCodeToString (Graphics (singleton $ PForeground c)) 
  <> s 
  <> escapeCodeToString (Graphics (singleton Reset))

carriageReturn :: String
carriageReturn = "\r"

foreign import _write :: String -> Promise Unit

write :: forall m. MonadAff m => String -> m Unit
write str = liftAff $ toAff $ _write str

log :: forall m. MonadAff m => String -> m Unit
log = liftEffect <<< Console.log

logAfterNewline :: forall m. MonadAff m => String -> m Unit
logAfterNewline msg = newline *> log msg

logShow :: forall m a. MonadAff m => Show a => a -> m Unit
logShow = log <<< show

logShowAfterNewline :: forall m a. MonadAff m => Show a => a -> m Unit
logShowAfterNewline = logAfterNewline <<< show

prefixed :: String -> Color -> String -> String -> Boolean -> Boolean -> String
prefixed prefix color emoji msg short colorize_ = 
  emoji 
  <> " " 
  <> (if short then "" else colorize color $ "[" <> prefix <> "] ") 
  <> (if colorize_ then colorize color msg else msg)

newline :: forall m. MonadAff m => m Unit
newline = log ""