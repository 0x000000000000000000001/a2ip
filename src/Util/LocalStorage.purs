module Util.LocalStorage
  ( setInLocalStorage
  , getInLocalStorage
  ) where

import Proem

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)

foreign import _setInLocalStorage :: String -> String -> Effect Unit
foreign import _getInLocalStorage :: String -> Effect (Nullable String)

setInLocalStorage :: ∀ m. MonadEffect m => String -> String -> m Unit
setInLocalStorage k v = liftEffect $ _setInLocalStorage k v

getInLocalStorage :: ∀ m. MonadEffect m => String -> m (Maybe String)
getInLocalStorage k = liftEffect $ toMaybe <$> _getInLocalStorage k
