module Component.Common.Link.Style.Sheet
  ( sheet
  ) where

import Component.Common.Link.Style.Link as Link
import Component.Common.Link.Type (State)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ p i. State -> HTML p i
sheet s = stylesheet do
  Link.style s.display