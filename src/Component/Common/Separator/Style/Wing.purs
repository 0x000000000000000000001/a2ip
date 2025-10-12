module Component.Common.Separator.Style.Wing
  ( classId
  , style
  ) where

import Proem hiding (top)

import CSS (backgroundColor, darken)
import CSS as CSS
import Util.Style (borderRadius1, flexGrow1, heightRem, loadingGrey, (.?))

classId :: String
classId = "nSWR5IYn6"

style :: CSS.CSS
style = do
  classId .? do
    flexGrow1
    heightRem 0.1
    backgroundColor $ darken 0.2 loadingGrey
    borderRadius1 3.0