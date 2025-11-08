module App.Component.Router.Menu.Style.Item.Child
  ( classId
  , style
  ) where

import Proem hiding (top, div)

import CSS (hover)
import CSS as CSS
import Util.Style.Style (backgroundColorRed, reflectStatelessClass, padding1, raw, widthPct100, (.&), (.?), (:?))

classId :: String
classId = reflectStatelessClass ι

style :: CSS.CSS
style = do
  classId .? do
    padding1 0.8
    widthPct100
    raw "transition" "background-color 0s"

  __hover :? do
    backgroundColorRed

  where 
  __hover = classId .& hover 