module Component.Page.About.Style.Card.Sheet
  ( sheet
  ) where

import Prelude

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Component.Page.About.Style.Card.Card (style)
import Component.Page.About.Style.Card.Portrait as Portrait
import Component.Page.About.Style.Card.Names as Names
import Component.Page.About.Style.Card.Line as Line 

sheet :: forall p i. HTML p i
sheet = stylesheet do
  style   
  Portrait.style
  Names.style 
  Line.style