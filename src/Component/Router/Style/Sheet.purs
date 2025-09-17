module Component.Router.Style.Sheet
  ( sheet
  ) where

import Prelude

import Component.Router.Style.Router (style)
import Halogen.HTML (HTML)
import Component.Router.Style.Core as Core
import Halogen.HTML.CSS (stylesheet)

sheet :: forall p i. HTML p i
sheet = stylesheet do
  style 
  Core.style