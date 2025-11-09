module App.Component.Common.Tooltip.Style.Outer.Outer
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (centerLeftToCenterRight, reflectStaticClass, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    widthPct100
    centerLeftToCenterRight
