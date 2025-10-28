module App.Component.Common.Loader.Style.Sheet
  ( sheet
  ) where

import App.Component.Common.Loader.Style.Loader as Loader
import CSS (Color)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ p i. Color -> HTML p i
sheet color = stylesheet do
  Loader.style color
