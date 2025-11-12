module App.Component.Page.About.Style.Members
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS (alignContent, flexStart)
import CSS as CSS
import Util.Style.Style (displayFlex, flexWrap, reflectStaticClass, justifyContentCenter, padding1, widthPct100, (.?))

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