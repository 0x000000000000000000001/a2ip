module Component.Page.About.Style.Sheet
  ( sheet
  ) where

import Prelude

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Component.Page.About.Style.About as About
import Component.Page.About.Style.Card.Index as Card 

sheet :: forall p i. HTML p i
sheet = stylesheet do
  About.style  
  Card.style 