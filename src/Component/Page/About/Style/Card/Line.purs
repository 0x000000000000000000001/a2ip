module Component.Page.About.Style.Card.Line
  ( classId
  , classIdWhenSecond
  , style
  ) where

import Prelude hiding (top)

import CSS (marginTop, rem, pct, width)
import CSS as CSS
import Utils.Style (raw, (<?))

classId :: String
classId = "wNMB3qHPD"

classIdWhenSecond :: String
classIdWhenSecond = "kvYjNVj86"

style :: CSS.CSS
style = do
  classId <? do
    marginTop (rem 0.6)
    width (pct 75.0)
    raw "transition" "background-color 0s; color 0s"