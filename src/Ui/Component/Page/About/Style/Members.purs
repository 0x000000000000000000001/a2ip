module App.Component.Page.About.Style.Members
  ( members
  , members_
  , staticClass
  , style
  )
  where

import Proem hiding (div, top)

import CSS (alignContent, flexStart)
import DOM.HTML.Indexed (HTMLdiv)
import Halogen.HTML (HTML, Node, div)
import CSS as CSS
import Util.Style.Style (class_, displayFlex, flexWrap, reflectStaticClass, justifyContentCenter, padding1, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignContent flexStart
    flexWrap
    padding1 1.3
    widthPct100

members :: ∀ w i. Node HTMLdiv w i
members props = div ([ class_ staticClass ] <> props)

members_ :: ∀ w i. Array (HTML w i) -> HTML w i
members_ = members []