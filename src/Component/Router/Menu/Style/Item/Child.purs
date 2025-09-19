module Component.Router.Menu.Style.Item.Child
  ( classId
  , style
  ) where

import Prelude hiding (top, div)

import CSS (backgroundColor, hover, pct, width, (?))
import CSS as CSS
import Utils.Style (red, padding, (.&), (.?))

classId :: String
classId = "A9EgPEH39"

style :: CSS.CSS
style = do
  classId .? do
    padding 0.8
    width (pct 100.0)
    CSS.key (CSS.fromString "transition") "background-color 0s"

  __hover ? do
    backgroundColor red

  where 
  __hover = classId .& hover 