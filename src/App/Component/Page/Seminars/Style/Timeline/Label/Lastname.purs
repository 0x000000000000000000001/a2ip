module App.Component.Page.Seminars.Style.Timeline.Label.Lastname
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (fontWeightBold, reflectStaticClass, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    fontWeightBold
    widthPct100

lastname :: ∀ w i. Node HTMLdiv w i
lastname props = div ([ class_ staticClass ] <> props)

lastname_ :: ∀ w i. Array (HTML w i) -> HTML w i
lastname_ = lastname []