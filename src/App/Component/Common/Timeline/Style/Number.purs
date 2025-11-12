module App.Component.Common.Timeline.Style.Number
  ( staticClass
  , style
  )
  where

import Proem hiding (top)

import CSS as CSS
import Util.Style.Style (reflectStaticClass, noCss, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    noCss
  
number :: ∀ w i. Node HTMLdiv w i
number props = div ([ class_ staticClass ] <> props)

number_ :: ∀ w i. Array (HTML w i) -> HTML w i
number_ = number []