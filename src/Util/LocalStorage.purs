module Util.LocalStorage
  ( getInLocalStorage
  , removeInLocalStorage
  , setInLocalStorage
  )
  where

import Proem

import Data.Maybe (Maybe)
import Effect.Class (class MonadEffect)
import Web.HTML (window)
import Web.HTML.Window (localStorage)
import Web.Storage.Storage (getItem, removeItem, setItem)

setInLocalStorage :: ∀ m. MonadEffect m => String -> String -> m Unit
setInLocalStorage k v = ʌ do 
  win <- window
  storage <- localStorage win
  setItem k v storage

getInLocalStorage :: ∀ m. MonadEffect m => String -> m (Maybe String)
getInLocalStorage k = ʌ do 
  win <- window
  storage <- localStorage win
  getItem k storage

removeInLocalStorage :: ∀ m. MonadEffect m => String -> m Unit
removeInLocalStorage k = ʌ do
  win <- window
  storage <- localStorage win
  removeItem k storage