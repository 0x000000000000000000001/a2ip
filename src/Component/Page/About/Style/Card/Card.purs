module Component.Page.About.Style.Card.Card
  ( classId
  , classIdWhenLoading
  , style
  ) where

import Prelude hiding (top)

import CSS (pct, width, (?))
import CSS as CSS
import Utils.Style (padding, (<?), (<&>))

classId :: String
classId = "xt156nvNM"

classIdWhenLoading :: String
classIdWhenLoading = "vrptC0jM2"

style :: CSS.CSS
style = do
  classId <? do
    width (pct 33.33)
    padding 1.0

  loading ? do
    padding 10.0 

    where loading = classId <&> classIdWhenLoading