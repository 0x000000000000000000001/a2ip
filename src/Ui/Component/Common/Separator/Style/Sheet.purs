module App.Component.Common.Separator.Style.Sheet
  ( sheet
  ) where

import App.Component.Common.Separator.Style.Separator as Separator
import App.Component.Common.Separator.Style.Text.Index as Text
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Proem (discard)

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  Separator.style
  Text.style