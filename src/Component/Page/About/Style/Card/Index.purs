module Component.Page.About.Style.Card.Index
  ( style
  ) where

import Prelude

import CSS as CSS
import Component.Page.About.Style.Card.Card as Card
import Component.Page.About.Style.Card.Line as Line
import Component.Page.About.Style.Card.Names as Names
import Component.Page.About.Style.Card.Portrait as Portrait

style :: CSS.CSS
style = do
  Card.style
  Portrait.style
  Names.style
  Line.style