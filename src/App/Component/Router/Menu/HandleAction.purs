module App.Component.Router.Menu.HandleAction (handleAction) where

import Proem hiding (top, div)

import App.Component.Router.Menu.Style.Menu (foldWidth)
import App.Component.Router.Menu.Type (Action(..), MenuM)
import App.Component.Router.Style.Router (animationDurationMs)
import Data.Int (toNumber)
import Effect.Aff (Milliseconds(..), delay)
import Halogen (get, modify_, subscribe')
import Halogen.Query.Event (eventListener)
import Util.Style (getRootFontSize)
import Web.HTML (window)
import Web.HTML.Event.EventTypes (click)
import Web.HTML.HTMLDocument (toEventTarget)
import Web.HTML.Window (document)
import Web.UIEvent.MouseEvent (clientX, fromEvent)

handleAction :: Action -> MenuM Unit
handleAction = case _ of
  Initialize -> do
    doc <- ʌ $ document =<< window
    subscribe' $ κ $ eventListener
      click
      (doc # toEventTarget)
      (map HandleDocClick ◁ fromEvent)

  ToggleFolding shouldFold -> do
    state <- get
    unless state.isAnimating do
      modify_ _ { isUnfold = not shouldFold, isAnimating = true }
      ʌ' $ delay (Milliseconds animationDurationMs)
      modify_ _ { isAnimating = false }
  
  HandleDocClick ev -> do
    state <- get
    when state.isUnfold do
      unless state.isAnimating do
        remInPx <- ʌ getRootFontSize
        let 
          foldWidthPx = foldWidth * remInPx
          mouseX = toNumber $ clientX ev
        when 
          (mouseX > foldWidthPx)
          (handleAction $ ToggleFolding true)
  
  FinishAnimation -> modify_ _ { isAnimating = false }

  DoNothing -> ηι