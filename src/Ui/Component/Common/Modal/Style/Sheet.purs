module Ui.Component.Common.Modal.Style.Sheet
  ( sheet
  ) where

import Ui.Component.Common.Modal.Style.Modal as Modal
import Ui.Component.Common.Modal.Type (State)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ input w i. State input -> HTML w i
sheet s = stylesheet do
  Modal.style s