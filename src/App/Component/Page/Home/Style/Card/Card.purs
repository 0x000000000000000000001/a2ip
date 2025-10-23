module App.Component.Page.Home.Style.Card.Card
  ( classId
  , classIdWhenLoaded
  , classIdWhenLoading
  , style
  )
  where

import Proem hiding (top)

import CSS (CSS) as CSS
import CSS (column, flexDirection, hover, (&))
import App.Component.Page.Home.Style.Card.Line as Line
import App.Component.Page.Home.Style.Card.Names as Names
import App.Component.Page.Home.Style.Card.Portrait as Portrait
import App.Component.Page.Home.Type (email, phone)
import Util.Style (alignItemsCenter, before, borderRadius1, content, deepClass, displayFlex, flexWrap, heightRem, justifyContentCenter, loading, nothing, padding1, textAlignCenter, widthPct, widthRem, (&.), (.&.), (.?), (:?))

classId :: String
classId = "xt156nvNM"

classIdWhenLoading :: String
classIdWhenLoading = "vrptC0jM2"

classIdWhenLoaded :: String
classIdWhenLoaded = "FI8nIaPpM"

style :: CSS.CSS
style = do
  classId .? do
    widthRem 30.0
    padding1 1.4
    textAlignCenter
    displayFlex
    justifyContentCenter
    alignItemsCenter
    flexWrap
    flexDirection column

  __loaded :? do 
    nothing

  ____hover :? do
    nothing

  ______portrait :? do
    borderRadius1 0.3

  __loading :? do
    nothing

  ____portrait :? do
    loading

  ____names :? do
    loading
    borderRadius1 0.3
    widthPct 40.0

  ____line :? do
    loading
    borderRadius1 0.3
    widthPct 60.0

  ______before :? do
    content ""

  ______phone :? do
    widthPct 30.0
    heightRem 1.6

  ______email :? do
    widthPct 45.0

  where
  __loaded = classId .&. classIdWhenLoaded
  ____hover = __loaded & hover
  deepClassHover = deepClass ____hover
  ______portrait = deepClassHover Portrait.classId
  __loading = classId .&. classIdWhenLoading
  deepClassLoading = deepClass __loading
  ____portrait = deepClassLoading Portrait.classId
  ____names = deepClassLoading Names.classId
  ____line = deepClassLoading Line.classId
  ______before = ____line & before
  ______phone = ____line &. Line.classIdWhen (ᴠ phone)
  ______email = ____line &. Line.classIdWhen (ᴠ email)