module Ui.Component.Router.Style.Sheet
  ( sheet
  ) where

import Proem

import Ui.Component.Router.Style.Router (style)
import Halogen.HTML (HTML)
import Ui.Component.Router.Style.Core as Core
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  style 
  Core.style