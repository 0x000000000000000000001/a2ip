module App.Component.Router.Menu.Style.Item.Child
  ( staticClass
  , style
  ) where

import Proem hiding (top, div)

import CSS (hover)
import CSS as CSS
import Util.Style.Style (backgroundColorRed, reflectStaticClass, padding1, raw, widthPct100, (.&), (.?), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    padding1 0.8
    widthPct100
    raw "transition" "background-color 0s"

  __hover :? do
    backgroundColorRed

  where 
  __hover = staticClass .& hover 