module Component.Router.Menu.Style.Item.Child
  ( classId
  , style
  ) where

import Proem hiding (top, div)

import CSS (hover)
import CSS as CSS
import Util.Style (backgroundColorRed, padding1, raw, widthPct100, (.&), (.?), (:?))

classId :: String
classId = "A9EgPEH39"

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