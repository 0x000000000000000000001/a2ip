module App.Component.Common.Input.Style.Input
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS (marginBottom, position, px, relative, width)
import CSS as CSS
import Util.Style ((.?))

classId :: String
classId = "arRAAae18"

style :: CSS.CSS
style = do
  classId .? do
    position relative
    marginBottom (px 16.0)
    width (px 300.0)
