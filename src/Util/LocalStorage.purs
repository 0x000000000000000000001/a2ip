module Util.LocalStorage
  ( getInLocalStorage
  , removeInLocalStorage
  , setInLocalStorage
  )
  where

import Proem

import Data.DateTime.Instant (unInstant)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Newtype (unwrap)
import Data.Time.Duration (Seconds(..))
import Effect.Class (class MonadEffect)
import Effect.Now (now)
import Simple.JSON (class ReadForeign, class WriteForeign, readJSON, writeJSON)
import Web.HTML (window)
import Web.HTML.Window (localStorage)
import Web.Storage.Storage (getItem, removeItem, setItem)

type StoredValue a = 
  { value :: a
  , expiresAtTs :: Maybe Number
  }

setInLocalStorage :: ∀ m a. MonadEffect m => WriteForeign a => String -> a -> Maybe Seconds -> m Unit
setInLocalStorage k v maybeTtl = ʌ do
  storage <- localStorage =<< window
  currentTime <- now
  
  let maybeExpiresAtTs = maybeTtl <#> \(Seconds ttl) -> ttl + (unwrap $ unInstant currentTime) / 1000.0
      stored = { value: v, expiresAtTs: maybeExpiresAtTs }
      
  setItem k (writeJSON stored) storage

getInLocalStorage :: ∀ m a. MonadEffect m => ReadForeign a => String -> m (Maybe a)
getInLocalStorage k = ʌ do
  storage <- localStorage =<< window
  
  maybeItem <- getItem k storage
  maybeItem
    ?? (\jsonStr -> do
      currentTime <- now
      
      let currentTs = (unwrap $ unInstant currentTime) / 1000.0
      
      case readJSON jsonStr of
        Left _ -> η Nothing
        Right (stored :: StoredValue a) -> 
          case stored.expiresAtTs of
            Nothing -> η (Just stored.value)
            Just expiresAtTs -> 
              expiresAtTs < currentTs
                ? do
                  removeItem k storage
                  η Nothing
                ↔ η (Just stored.value)
    )
    ⇔ η Nothing

removeInLocalStorage :: ∀ m. MonadEffect m => String -> m Unit
removeInLocalStorage k = ʌ do
  storage <- localStorage =<< window
  removeItem k storage