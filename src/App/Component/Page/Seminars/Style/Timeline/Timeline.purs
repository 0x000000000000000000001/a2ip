module App.Component.Page.Seminars.Style.Timeline.Timeline
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (alignItemsCenter, displayFlex, reflectStaticClass, justifyContentCenter, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    widthRem 10.0
    displayFlex
    justifyContentCenter
    alignItemsCenter