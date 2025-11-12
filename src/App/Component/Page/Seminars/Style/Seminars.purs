module App.Component.Page.Seminars.Style.Seminars
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS (alignItems, flexStart)
import CSS as CSS
import Util.Style.Style (displayFlex, reflectStaticClass, justifyContentCenter, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignItems flexStart
    widthPct100

seminars :: ∀ w i. Node HTMLdiv w i
seminars props = div ([ class_ staticClass ] <> props)

seminars_ :: ∀ w i. Array (HTML w i) -> HTML w i
seminars_ = seminars []