module Util.LocalStorage
  ( setInLocalStorage
  , getInLocalStorage
  ) where

import Proem

import Data.Maybe (Maybe)
import Effect.Class (class MonadEffect, liftEffect)
import Web.HTML (window)
import Web.HTML.Window (localStorage)
import Web.Storage.Storage (getItem, setItem)

setInLocalStorage :: ∀ m. MonadEffect m => String -> String -> m Unit
setInLocalStorage k v = liftEffect do 
  win <- window
  storage <- localStorage win
  setItem k v storage

getInLocalStorage :: ∀ m. MonadEffect m => String -> m (Maybe String)
getInLocalStorage k = liftEffect do 
  win <- window
  storage <- localStorage win
  getItem k storage
