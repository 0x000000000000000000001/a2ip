module App.Component.Common.Modal.Style.Core
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style (backgroundColorWhite, borderRadius1, margin2, padding1, positionRelative, widthRem, (.?))

classId :: String
classId = "J9zhpuRLP"

style :: CSS.CSS
style = do
  classId .? do
    positionRelative
    backgroundColorWhite
    widthRem 60.0
    padding1 2.0
    borderRadius1 0.5
    margin2 8.0 2.0