module Ui.Component.Page.About.Style.Card.Index
  ( style
  ) where

import Proem

import CSS as CSS
import Ui.Component.Page.About.Style.Card.Card as Card
import Ui.Component.Page.About.Style.Card.Line as Line
import Ui.Component.Page.About.Style.Card.Names as Names
import Ui.Component.Page.About.Style.Card.Portrait as Portrait

style :: CSS.CSS
style = do
  Card.style
  Portrait.style
  Names.style
  Line.style