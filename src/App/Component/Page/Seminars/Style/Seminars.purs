module App.Component.Page.Seminars.Style.Seminars
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, flexStart)
import CSS as CSS
import Util.Style.Style (displayFlex, reflectStaticClass, justifyContentCenter, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignItems flexStart
    widthPct100