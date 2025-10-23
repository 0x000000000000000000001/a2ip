module App.Component.Page.Home.Style.Sheet
  ( sheet
  ) where

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Page.Home.Style.Home as Home

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Home.style  