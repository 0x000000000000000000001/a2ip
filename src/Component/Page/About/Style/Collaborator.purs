module Component.Page.About.Style.Collaborator
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style (fontSizePct, padding4, textAlignCenter, widthPct100, (.?))

classId :: String
classId = "HT3ODhnO9"

style :: CSS.CSS
style = do
  classId .? do
    widthPct100
    textAlignCenter
    fontSizePct 105.0
    padding4 0.0 0.6 0.4 0.6