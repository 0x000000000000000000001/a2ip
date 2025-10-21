module Component.Router.Menu.HandleAction (handleAction) where

import Proem hiding (top, div)

import Component.Router.Menu.Style.Menu (foldWidth)
import Component.Router.Menu.Type (Action(..), ComponentM)
import Component.Router.Style.Core (animationDurationMs)
import Data.Int (toNumber)
import Effect.Aff (Milliseconds(..), delay)
import Effect.Aff.Class (liftAff)
import Effect.Class (liftEffect)
import Halogen (get, modify_)
import Util.Style (getRootFontSize)
import Web.UIEvent.MouseEvent (clientX)
import Component.Router.Menu.Type (ComponentM)

handleAction :: Action -> ComponentM Unit
handleAction = case _ of
  ToggleFolding shouldFold -> do
    state <- get
    unless state.isAnimating do
      modify_ _ { isUnfold = not shouldFold, isAnimating = true }
      liftAff $ delay (Milliseconds animationDurationMs)
      modify_ _ { isAnimating = false }
  
  HandleItemClick ev -> do
    state <- get
    unless state.isAnimating do
      remInPixels <- liftEffect getRootFontSize
      let 
        foldedWidthPx = foldWidth * remInPixels
        mouseX = toNumber $ clientX ev
      when (mouseX > foldedWidthPx) $ handleAction $ ToggleFolding true
  
  FinishAnimation -> modify_ _ { isAnimating = false }