module App.Component.Router.Style.Sheet
  ( sheet
  ) where

import Proem

import App.Component.Router.Style.Router (style)
import Halogen.HTML (HTML)
import App.Component.Router.Style.Core as Core
import Halogen.HTML.CSS (stylesheet)

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  style 
  Core.style