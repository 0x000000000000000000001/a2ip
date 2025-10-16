module Component.Router.Menu.HandleAction (handleAction) where

import Proem hiding (top, div)

import Capability.AppM (AppM)
import Component.Router.Menu.Style.Menu (foldWidth)
import Component.Router.Menu.Type (Action(..), Output, Slots, State)
import Data.Int (toNumber)
import Effect (Effect)
import Effect.Class (liftEffect)
import Halogen (HalogenM, modify_)
import Util.Style (getRootFontSize)
import Web.UIEvent.MouseEvent (clientX)

handleAction :: Action -> HalogenM State Action Slots Output AppM Unit
handleAction = case _ of
  ToggleFolding bool -> modify_ _ { isUnfold = not bool }
  HandleItemClick ev -> do
    -- Only close if mouse is beyond folded width
    -- Calculate rem to pixels: get root element font-size
    remInPixels <- liftEffect getRootFontSize
    let 
      foldedWidthPx = foldWidth * remInPixels
      mouseX = toNumber $ clientX ev
    when (mouseX > foldedWidthPx) $ handleAction $ ToggleFolding true