module Component.Common.Link.Style.Sheet
  ( sheet
  ) where

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Component.Common.Link.Style.Link as Link

sheet :: forall p i. HTML p i
sheet = stylesheet do
  Link.style 