module App.Component.Router.Menu.Style.Item.Child
  ( statelessClass
  , style
  ) where

import Proem hiding (top, div)

import CSS (hover)
import CSS as CSS
import Util.Style.Style (backgroundColorRed, reflectStatelessClass, padding1, raw, widthPct100, (.&), (.?), (:?))

statelessClass :: String
statelessClass = reflectStatelessClass ι

style :: CSS.CSS
style = do
  statelessClass .? do
    padding1 0.8
    widthPct100
    raw "transition" "background-color 0s"

  __hover :? do
    backgroundColorRed

  where 
  __hover = statelessClass .& hover 