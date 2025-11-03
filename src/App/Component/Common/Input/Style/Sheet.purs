module App.Component.Common.Input.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import App.Component.Common.Input.Style.Field as Field
import App.Component.Common.Input.Style.Input as Input
import App.Component.Common.Input.Style.Label as Label
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ p i s. s -> HTML p i
sheet _ = stylesheet do
  Field.style
  Input.style
  Label.style
