module App.Component.Common.Modal.Style.Core
  ( classId
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style (backgroundColorWhite, borderRadius1, padding1, widthRem, (.?))

classId :: String
classId = "J9zhpuRLP"

style :: CSS.CSS
style = do
  classId .? do
    backgroundColorWhite
    widthRem 60.0
    padding1 2.0
    borderRadius1 0.5