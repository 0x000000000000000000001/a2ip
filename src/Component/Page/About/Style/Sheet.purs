module Component.Page.About.Style.Sheet
  ( sheet
  ) where

import Prelude

import Component.Page.About.Style.About (style)
import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Component.Page.About.Style.Card.Card as Card
import Component.Page.About.Style.Card.Portrait as CardPortrait
import Component.Page.About.Style.Card.Names as CardNames
import Component.Page.About.Style.Card.Line as CardLine 

sheet :: forall p i. HTML p i
sheet = stylesheet do
  style  
  Card.style
  CardPortrait.style
  CardNames.style
  CardLine.style