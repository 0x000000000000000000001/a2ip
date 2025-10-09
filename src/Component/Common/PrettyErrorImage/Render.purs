module Component.Common.PrettyErrorImage.Render 
  ( render
  )
  where

import Prelude hiding (div)

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.Type (Action, Slots, State)
import Halogen (ComponentHTML)
import Halogen.HTML (text) 

render :: State -> ComponentHTML Action Slots AppM
render state = text "pretty error image"