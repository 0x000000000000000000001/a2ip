module Component.Router.Menu.HandleAction (handleAction) where

import Proem hiding (top, div)

import Capability.AppM (AppM)
import Component.Router.Menu.Style.Menu (foldWidth)
import Component.Router.Menu.Type (Action(..), Output, Slots, State)
import Data.Int (toNumber)
import Effect.Aff (Milliseconds(..), delay)
import Effect.Aff.Class (liftAff)
import Effect.Class (liftEffect)
import Halogen (HalogenM, get, modify_)
import Util.Style (getRootFontSize)
import Web.UIEvent.MouseEvent (clientX)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of
  ToggleFolding shouldFold -> do
    state <- get
    -- Ignore les événements si une animation est en cours
    unless state.isAnimating do
      modify_ _ { isUnfold = not shouldFold, isAnimating = true }
      -- Durée de l'animation CSS (à ajuster selon votre transition)
      liftAff $ delay (Milliseconds 300.0)
      modify_ _ { isAnimating = false }
  
  HandleItemClick ev -> do
    state <- get
    -- Ignore si animation en cours
    unless state.isAnimating do
      -- Only close if mouse is beyond folded width
      remInPixels <- liftEffect getRootFontSize
      let 
        foldedWidthPx = foldWidth * remInPixels
        mouseX = toNumber $ clientX ev
      when (mouseX > foldedWidthPx) $ handleAction $ ToggleFolding true
  
  FinishAnimation -> modify_ _ { isAnimating = false }