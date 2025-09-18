module Component.Page.About.Style.Card.Card
  ( classId
  , classIdWhenLoading
  , style
  ) where

import Prelude hiding (top)

import CSS (backgroundColor, borderColor, borderRadius, color, pct, rem, width, (?))
import CSS as CSS
import Component.Page.About.Style.Card.Names as Names
import Component.Page.About.Style.Card.Portrait as Portrait
import Utils.Style (deep, loadingGrey, nothing, padding, raw, (<&>), (<?))

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
    backgroundColor loadingGrey
    borderColor loadingGrey

  o Names.classId ? do
    color loadingGrey
    backgroundColor loadingGrey
    borderRadius (rem 0.3) (rem 0.3) (rem 0.3) (rem 0.3)
    width (pct 70.0)
    
  where
  loading = classId <&> classIdWhenLoading
  o = deep loading