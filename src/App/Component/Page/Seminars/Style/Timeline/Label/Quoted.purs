module App.Component.Page.Seminars.Style.Timeline.Label.Quoted
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (flexGrow1, padding1, reflectStaticClass, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    flexGrow1
    padding1 0.5