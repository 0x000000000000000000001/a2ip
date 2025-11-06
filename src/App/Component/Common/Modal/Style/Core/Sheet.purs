module App.Component.Common.Modal.Style.Core.Sheet
  ( sheet
  ) where

import Proem (discard)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Common.Modal.Style.Core.Core as Core
import App.Component.Common.Modal.Style.Core.Close as Close

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  Core.style 
  Close.style 