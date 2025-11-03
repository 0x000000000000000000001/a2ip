module App.Component.Common.Input.Style.Label
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (bold, color, fontWeight, marginBottom, px, rgb)
import CSS as CSS
import Util.Style ((.?))

classId :: String
classId = "OmK5nX9TU"

style :: CSS.CSS
style = do
  classId .? do
    fontWeight bold
    marginBottom (px 8.0)
    color $ rgb 51 51 51
