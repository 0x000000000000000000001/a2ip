module App.Component.Page.About.Style.Card.Card
  ( card
  , card_
  , staticClass
  , staticClassWhenLoaded
  , staticClassWhenLoading
  , style
  )
  where

import Proem hiding (div, top)

import App.Component.Page.About.Style.Card.Line as Line
import App.Component.Page.About.Style.Card.Names as Names
import App.Component.Page.About.Style.Card.Portrait as Portrait
import CSS (CSS) as CSS
import CSS (column, flexDirection, hover, (&))
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import Util.Proxy.Dictionary.Email (email_)
import Util.Proxy.Dictionary.Loaded (loaded_)
import Util.Proxy.Dictionary.Loading (loading_)
import Util.Proxy.Dictionary.Phone (phone_)
import Util.Style.Style (alignItemsCenter, before, borderRadiusRem1, classes, content, displayFlex, flexWrap, heightRem, justifyContentCenter, loading, noCss, padding1, refineClass', reflectStaticClass, textAlignCenter, typedDeepClass, widthPct, widthRem, (&.), (.&.), (.?), (:?))

staticClass :: String
staticClass = reflectStaticClass ι

staticClassWhenLoading :: String
staticClassWhenLoading = refineClass' staticClass loading_

staticClassWhenLoaded :: String
staticClassWhenLoaded = refineClass' staticClass loaded_

style :: CSS.CSS
style = do
  staticClass .? do
    widthRem 30.0
    padding1 1.4
    textAlignCenter
    displayFlex
    justifyContentCenter
    alignItemsCenter
    flexWrap
    flexDirection column

  __loaded :? do 
    noCss

  ____hover :? do
    noCss

  ______portrait :? do
    borderRadiusRem1 0.3

  __loading :? do
    noCss

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
  __loaded = staticClass .&. staticClassWhenLoaded
  ____hover = __loaded & hover
  deepClassHover = typedDeepClass ____hover
  ______portrait = deepClassHover Portrait.staticClass
  __loading = staticClass .&. staticClassWhenLoading
  deepClassLoading = typedDeepClass __loading
  ____names = deepClassLoading Names.staticClass
  ____line = deepClassLoading Line.staticClass
  ______before = ____line & before
  ______phone = ____line &. Line.staticClassWhen phone_
  ______email = ____line &. Line.staticClassWhen email_

card :: ∀ w i. Boolean -> Node HTMLdiv w i
card loading props = div ([ classes [staticClass, loading ? staticClassWhenLoading ↔ staticClassWhenLoaded] ] <> props)

card_ :: ∀ w i. Boolean -> Array (HTML w i) -> HTML w i
card_ loading = card loading []