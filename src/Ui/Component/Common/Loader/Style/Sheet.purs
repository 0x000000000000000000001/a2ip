module Ui.Component.Common.Loader.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import Ui.Component.Common.Loader.Style.Loader as Loader
import Ui.Component.Common.Loader.Style.Animation as Animation
import CSS (Color)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ w i. Color -> HTML w i
sheet color = stylesheet do
  Animation.style color
  Loader.style
