module Component.Page.About.Style.Card.Card
  ( classId
  , classIdWhenLoading
  , style
  ) where

import Prelude hiding (top)

import CSS (pct, rem, width, (?))
import CSS as CSS
import Utils.Style (deep, padding, nothing, (<&>), (<?))
import Component.Page.About.Style.Card.Portrait as Portrait

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
    nothing

  o Portrait.classId ? do
    width (rem 2.0)

  where
  loading = classId <&> classIdWhenLoading
  o = deep loading