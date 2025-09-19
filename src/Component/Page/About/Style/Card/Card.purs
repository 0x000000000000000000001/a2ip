module Component.Page.About.Style.Card.Card
  ( classId
  , classIdWhenLoading
  , style
  ) where

import Prelude hiding (top)

import CSS (CSS) as CSS
import CSS (alignItems, column, flexDirection, justifyContent, (&), (?))
import CSS.Common (center) as CSS
import CSS.TextAlign (center, textAlign)
import Component.Page.About.Style.Card.Line as Line
import Component.Page.About.Style.Card.Names as Names
import Component.Page.About.Style.Card.Portrait as Portrait
import Utils.Style (before, borderRadius1, content, deepClass, displayFlex, flexWrap, heightRem, loading, nothing, padding1, widthPct, widthRem, (&.), (.&.), (.?))

classId :: String
classId = "xt156nvNM"

classIdWhenLoading :: String
classIdWhenLoading = "vrptC0jM2"

style :: CSS.CSS
style = do
  classId .? do
    widthRem 30.0
    padding1 1.4
    textAlign center
    displayFlex
    justifyContent CSS.center
    alignItems CSS.center
    flexWrap
    flexDirection column

  __loading ? do
    nothing

  ____portrait ? do
    loading

  ____names ? do
    loading
    borderRadius1 0.3
    widthPct 40.0

  ____line ? do
    loading
    borderRadius1 0.3
    widthPct 60.0

  ______before ? do
    content ""

  ______phone ? do
    widthPct 30.0
    heightRem 1.6

  ______email ? do
    widthPct 45.0

  where
  __loading = classId .&. classIdWhenLoading
  deepClassLoading = deepClass __loading
  ____portrait = deepClassLoading Portrait.classId
  ____names = deepClassLoading Names.classId
  ____line = deepClassLoading Line.classId
  ______before = ____line & before
  ______phone = ____line &. Line.classIdWhen "phone"
  ______email = ____line &. Line.classIdWhen "email"