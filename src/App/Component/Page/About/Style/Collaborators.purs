module App.Component.Page.About.Style.Collaborators
  ( staticClass
  , style
  ) where

import Proem hiding (top)

import CSS (alignContent)
import CSS as CSS
import CSS.Common (center)
import Util.Style.Style (displayFlex, flexWrap, reflectStaticClass, justifyContentCenter, padding4, widthPct100, (.?))

staticClass :: String
staticClass = reflectStaticClass ι

style :: CSS.CSS
style = do
  staticClass .? do
    displayFlex
    justifyContentCenter
    alignContent center
    flexWrap
    padding4 1.0 1.3 3.0 1.3
    widthPct100

collaborators :: ∀ w i. Node HTMLdiv w i
collaborators props = div ([ class_ staticClass ] <> props)

collaborators_ :: ∀ w i. Array (HTML w i) -> HTML w i
collaborators_ = collaborators []