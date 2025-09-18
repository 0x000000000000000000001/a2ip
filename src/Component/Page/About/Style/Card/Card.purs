module Component.Page.About.Style.Card.Card
  ( classId
  , classIdWhenLoading
  , style
  ) where

import Prelude hiding (top)

import CSS (CSS) as CSS
import CSS (alignItems, backgroundColor, borderColor, borderRadius, color, column, display, flex, flexDirection, flexWrap, height, justifyContent, pct, rem, width, wrap, (?))
import CSS.Common (center) as CSS
import CSS.TextAlign (center, textAlign)
import Component.Page.About.Style.Card.Line as Line
import Component.Page.About.Style.Card.Names as Names
import Component.Page.About.Style.Card.Portrait as Portrait
import Utils.Style (deep_, loadingGrey, nothing, padding, (&>), (<&>), (<?))

classId :: String
classId = "xt156nvNM"

classIdWhenLoading :: String
classIdWhenLoading = "vrptC0jM2"

style :: CSS.CSS
style = do
  classId <? do
    width (rem 30.0)
    padding 2.0
    textAlign center
    display flex
    justifyContent CSS.center
    alignItems CSS.center
    flexWrap wrap
    flexDirection column

  __loading ? do
    nothing

  ____portrait ? do
    backgroundColor loadingGrey
    borderColor loadingGrey

  ____names ? do
    color loadingGrey
    backgroundColor loadingGrey
    borderRadius (rem 0.3) (rem 0.3) (rem 0.3) (rem 0.3)
    width (pct 40.0)

  ____line ? do
    color loadingGrey
    backgroundColor loadingGrey
    borderRadius (rem 0.3) (rem 0.3) (rem 0.3) (rem 0.3)
    width (pct 60.0)

  ______2nd ? do
    width (pct 30.0)
    height (rem 1.6)

  ______3rd ? do
    width (pct 45.0)

  where
  __loading = classId <&> classIdWhenLoading
  deepLoading = deep_ __loading
  ____portrait = deepLoading Portrait.classId
  ____names = deepLoading Names.classId
  ____line = deepLoading Line.classId
  ______2nd = ____line &> (Line.classIdWhen "phone") 
  ______3rd = ____line &> (Line.classIdWhen "email")  