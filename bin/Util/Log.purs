module Bin.Util.Log
  ( CliColor(..)
  , ansiColorCode
  , colorize
  , debug
  , debugAfterNewline
  , debugShort
  , debugShortAfterNewline
  , debugShortShow
  , debugShow
  , debugShowAfterNewline
  , error
  , errorAfterNewline
  , errorShort
  , errorShortAfterNewline
  , errorShortShow
  , errorShow
  , errorShowAfterNewline
  , info
  , infoAfterNewline
  , infoShort
  , infoShortAfterNewline
  , infoShortShow
  , infoShow
  , log
  , logAfterNewline
  , logShow
  , logShowAfterNewline
  , newline
  , runBinAff
  , success
  , successAfterNewline
  , successShort
  , successShortAfterNewline
  , successShortShow
  , successShow
  , successShowAfterNewline
  , warn
  , warnAfterNewline
  , warnShort
  , warnShortAfterNewline
  , warnShortShow
  , warnShow
  , warnShowAfterNewline
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
  handleResult (Left e) = Console.error $ "❌ Fatal error: " <> show e
  handleResult (Right _) = pure unit

-- | Écrit sur stdout sans ajouter de retour à la ligne (utile pour les mises à jour en place)
foreign import writeStdout :: String -> Effect Unit

write :: forall m. MonadEffect m => String -> m Unit
write = liftEffect <<< writeStdout

log :: forall m. MonadEffect m => String -> m Unit
log = liftEffect <<< Console.log

logAfterNewline :: forall m. MonadEffect m => String -> m Unit
logAfterNewline msg = newline *> log msg

logShow :: forall m a. MonadEffect m => Show a => a -> m Unit
logShow = log <<< show

logShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
logShowAfterNewline = logAfterNewline <<< show

debug :: forall m. MonadEffect m => String -> m Unit
debug = liftEffect <<< Console.debug <<< ((colorize Grey "🪲 [debug] ") <> _)

debugAfterNewline :: forall m. MonadEffect m => String -> m Unit
debugAfterNewline msg = newline *> debug msg

debugShort :: forall m. MonadEffect m => String -> m Unit
debugShort = liftEffect <<< Console.debug <<< ((colorize Grey "🪲  ") <> _)

debugShortAfterNewline :: forall m. MonadEffect m => String -> m Unit
debugShortAfterNewline msg = newline *> debugShort msg

debugShortShow :: forall m a. MonadEffect m => Show a => a -> m Unit
debugShortShow = debugShort <<< show

debugShow :: forall m a. MonadEffect m => Show a => a -> m Unit
debugShow = debug <<< show

debugShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
debugShowAfterNewline = debugAfterNewline <<< show

info :: forall m. MonadEffect m => String -> m Unit
info = liftEffect <<< Console.info <<< ((colorize Blue "ℹ️ [info] ") <> _)

infoAfterNewline :: forall m. MonadEffect m => String -> m Unit
infoAfterNewline msg = newline *> info msg

infoShort :: forall m. MonadEffect m => String -> m Unit
infoShort = liftEffect <<< Console.info <<< ((colorize Blue "ℹ️  ") <> _)

infoShortAfterNewline :: forall m. MonadEffect m => String -> m Unit
infoShortAfterNewline msg = newline *> infoShort msg

infoShortShow :: forall m a. MonadEffect m => Show a => a -> m Unit
infoShortShow = infoShort <<< show

infoShow :: forall m a. MonadEffect m => Show a => a -> m Unit
infoShow = info <<< show

success :: forall m. MonadEffect m => String -> m Unit
success = liftEffect <<< Console.log <<< ((colorize Green "✅[success] ") <> _)

successAfterNewline :: forall m. MonadEffect m => String -> m Unit
successAfterNewline msg = newline *> success msg

successShort :: forall m. MonadEffect m => String -> m Unit
successShort = liftEffect <<< Console.log <<< ((colorize Green "✅ ") <> _)

successShortAfterNewline :: forall m. MonadEffect m => String -> m Unit
successShortAfterNewline msg = newline *> successShort msg

successShortShow :: forall m a. MonadEffect m => Show a => a -> m Unit
successShortShow = successShort <<< show

successShow :: forall m a. MonadEffect m => Show a => a -> m Unit
successShow = success <<< show

successShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
successShowAfterNewline = successAfterNewline <<< show

error :: forall m. MonadEffect m => String -> m Unit
error = liftEffect <<< Console.error <<< ((colorize Red "❌[error] ") <> _)

errorAfterNewline :: forall m. MonadEffect m => String -> m Unit
errorAfterNewline msg = newline *> error msg

errorShort :: forall m. MonadEffect m => String -> m Unit
errorShort = liftEffect <<< Console.error <<< ((colorize Red "❌ ") <> _)

errorShortAfterNewline :: forall m. MonadEffect m => String -> m Unit
errorShortAfterNewline msg = newline *> errorShort msg

errorShortShow :: forall m a. MonadEffect m => Show a => a -> m Unit
errorShortShow = errorShort <<< show

errorShow :: forall m a. MonadEffect m => Show a => a -> m Unit
errorShow = error <<< show

errorShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
errorShowAfterNewline = errorAfterNewline <<< show

warn :: forall m. MonadEffect m => String -> m Unit
warn = liftEffect <<< Console.warn <<< ((colorize Yellow "⚠️ [warning] ") <> _)

warnAfterNewline :: forall m. MonadEffect m => String -> m Unit
warnAfterNewline msg = newline *> warn msg

warnShort :: forall m. MonadEffect m => String -> m Unit
warnShort = liftEffect <<< Console.warn <<< ((colorize Yellow "⚠️ ") <> _)

warnShortAfterNewline :: forall m. MonadEffect m => String -> m Unit
warnShortAfterNewline msg = newline *> warnShort msg

warnShortShow :: forall m a. MonadEffect m => Show a => a -> m Unit
warnShortShow = warnShort <<< show

warnShow :: forall m a. MonadEffect m => Show a => a -> m Unit
warnShow = warn <<< show

warnShowAfterNewline :: forall m a. MonadEffect m => Show a => a -> m Unit
warnShowAfterNewline = warnAfterNewline <<< show

newline :: forall m. MonadEffect m => m Unit
newline = log "\n"