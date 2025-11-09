module App.Component.Page.Seminars.Style.Poster
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS (alignItems, column, flexDirection)
import CSS as CSS
import CSS.Common (center)
import Util.Style.Style (displayFlex, flexGrow1, reflectStaticClass, justifyContentCenter, padding1, positionSticky, top0, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignItems center
    flexDirection column
    widthRem 1.0
    flexGrow1
    positionSticky
    top0
    padding1 2.0