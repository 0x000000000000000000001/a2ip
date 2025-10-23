module App.Util.Capability.Log where

import Proem

import Util.Log (Level)

class Monad m <= Log m where
  log :: Level -> String -> m Unit
  logShow :: ∀ a. Show a => Level -> a -> m Unit
  info :: String -> m Unit
  infoShow :: ∀ a. Show a => a -> m Unit
  debug :: String -> m Unit
  debugShow :: ∀ a. Show a => a -> m Unit
  warn :: String -> m Unit
  warnShow :: ∀ a. Show a => a -> m Unit
  error :: String -> m Unit
  errorShow :: ∀ a. Show a => a -> m Unit
