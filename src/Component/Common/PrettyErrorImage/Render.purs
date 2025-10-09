module Component.Common.PrettyErrorImage.Render 
  ( render
  )
  where

import Prelude hiding (div)

import Capability.AppM (AppM)
import Component.Common.PrettyErrorImage.Type (Action, Slots, State)
import Halogen (ComponentHTML)
import Halogen.HTML (img, text)

render :: State _ -> ComponentHTML Action Slots AppM
render s = if s.errored then text "error" else img s.iProps 