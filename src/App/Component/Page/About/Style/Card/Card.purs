module App.Component.Page.About.Style.Card.Card
  ( classId
  , classIdWhenLoaded
  , classIdWhenLoading
  , style
  )
  where

import Proem hiding (top)

import App.Component.Page.About.Style.Card.Line as Line
import App.Component.Page.About.Style.Card.Names as Names
import App.Component.Page.About.Style.Card.Portrait as Portrait
import CSS (CSS) as CSS
import CSS (column, flexDirection, hover, (&))
import Util.Proxy.Dictionary.Email (email_)
import Util.Proxy.Dictionary.Loaded (loaded_)
import Util.Proxy.Dictionary.Loading (loading_)
import Util.Proxy.Dictionary.Phone (phone_)
import Util.Style.Style (alignItemsCenter, before, borderRadiusRem1, content, displayFlex, flexWrap, heightRem, justifyContentCenter, loading, nothing, padding1, refineClass, reflectHashModuleName, textAlignCenter, typedDeepClass, widthPct, widthRem, (&.), (.&.), (.?), (:?))

classId :: String
classId = reflectHashModuleName ι

classIdWhenLoading :: String
classIdWhenLoading = refineClass classId loading_

classIdWhenLoaded :: String
classIdWhenLoaded = refineClass classId loaded_

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
    borderRadiusRem1 0.3

  __loading :? do
    nothing

  ____portrait :? do
    loading

  ____names :? do
    loading
    borderRadiusRem1 0.3
    widthPct 40.0

  ____line :? do
    loading
    borderRadiusRem1 0.3
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
  deepClassHover = typedDeepClass ____hover
  ______portrait = deepClassHover Portrait.classId
  __loading = classId .&. classIdWhenLoading
  deepClassLoading = typedDeepClass __loading
  ____portrait = deepClassLoading Portrait.classId
  ____names = deepClassLoading Names.classId
  ____line = deepClassLoading Line.classId
  ______before = ____line & before
  ______phone = ____line &. Line.classIdWhen phone_
  ______email = ____line &. Line.classIdWhen email_