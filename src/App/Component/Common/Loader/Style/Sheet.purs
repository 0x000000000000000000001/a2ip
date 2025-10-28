module App.Component.Common.Loader.Style.Sheet
  ( sheet
  ) where

import Proem (discard)
import App.Component.Common.Loader.Style.Loader as Loader
import App.Component.Common.Loader.Style.Animation as Animation
import CSS (Color)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ p i. Color -> HTML p i
sheet color = stylesheet do
  Animation.style color
  Loader.style
