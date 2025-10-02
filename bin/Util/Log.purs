module Utils.CLI
  ( runBinAff
  , logInfo
  , logSuccess
  , logError
  , logWarning
  ) where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, runAff_)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console as Console
import Effect.Exception (Error)

runBinAff :: Aff Unit -> Effect Unit
runBinAff action = runAff_ handleResult action
  where
  handleResult :: Either Error Unit -> Effect Unit
  handleResult (Left error) = Console.error $ "❌ Fatal error: " <> show error
  handleResult (Right _) = pure unit

logInfo :: forall m. MonadEffect m => String -> m Unit
logInfo msg = liftEffect $ Console.info $ "ℹ️ Info: " <> msg

logSuccess :: forall m. MonadEffect m => String -> m Unit
logSuccess msg = liftEffect $ Console.log $ "✅ Success: " <> msg

logError :: forall m. MonadEffect m => String -> m Unit
logError msg = liftEffect $ Console.error $ "❌ Error: " <> msg

logWarning :: forall m. MonadEffect m => String -> m Unit
logWarning msg = liftEffect $ Console.warn $ "⚠️ Warning: " <> msg
