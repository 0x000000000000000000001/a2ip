module Ui.Component.Common.Input.Style.Sheet
  ( sheet
  ) where

import Ui.Component.Common.Input.Style.Field as Field
import Ui.Component.Common.Input.Style.Input as Input
import Ui.Component.Common.Input.Style.Label as Label
import Ui.Component.Common.Input.Type (State)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Proem (discard)

sheet :: ∀ w i. State -> HTML w i
sheet s = stylesheet do
  Field.style s
  Input.style
  Label.style
