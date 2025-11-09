module App.Component.Common.Timeline.Style.Line
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import App.Component.Common.Timeline.Style.Util (grey)
import CSS (backgroundColor)
import CSS as CSS
import Util.Style.Style (borderRadiusRem1, reflectStaticClass, heightPct100, topCenterToTopCenter, widthRem, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    topCenterToTopCenter
    widthRem 0.24
    borderRadiusRem1 1.0
    backgroundColor grey
    heightPct100