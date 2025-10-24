module App.Component.Router.Menu.HandleAction (handleAction) where

import Proem hiding (top, div)

import App.Component.Router.Menu.Style.Menu (foldWidth)
import App.Component.Router.Menu.Type (Action(..), MenuM)
import App.Component.Router.Style.Router (animationDurationMs)
import Data.Int (toNumber)
import Effect.Aff (Milliseconds(..), delay)
import Effect.Aff.Class (liftAff)
import Effect.Class (liftEffect)
import Halogen (get, modify_)
import Util.Style (getRootFontSize)
import Web.UIEvent.MouseEvent (clientX)

handleAction :: Action -> MenuM Unit
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
      remInPixels <- ʌ getRootFontSize
      let 
        foldedWidthPx = foldWidth * remInPixels
        mouseX = toNumber $ clientX ev
      when (mouseX > foldedWidthPx) $ handleAction $ ToggleFolding true
  
  FinishAnimation -> modify_ _ { isAnimating = false }