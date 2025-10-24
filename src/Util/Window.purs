module Util.Window
  ( getScreenVerticalCenter
  ) where

import Proem

import Data.Int (toNumber)
import Effect.Class (class MonadEffect, liftEffect)
import Web.HTML (window)
import Web.HTML.Window (innerHeight)

-- | Get the vertical center of the screen
getScreenVerticalCenter :: ∀ m. MonadEffect m => m Number
getScreenVerticalCenter = liftEffect do
  win <- window
  screenHeight <- innerHeight win
  η $ toNumber screenHeight / 2.0