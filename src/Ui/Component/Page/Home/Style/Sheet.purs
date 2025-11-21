module Ui.Component.Page.Home.Style.Sheet
  ( sheet
  ) where

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Ui.Component.Page.Home.Style.Home as Home

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  Home.style  