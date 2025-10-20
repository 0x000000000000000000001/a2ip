module Component.Common.Carrousel.Style.Control.Icon
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style (positionRelative, (.?))

classId :: String
classId = "m6qHR69Aa"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative