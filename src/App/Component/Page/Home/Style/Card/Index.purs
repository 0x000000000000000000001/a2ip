module App.Component.Page.Home.Style.Card.Index
  ( style
  ) where

import Proem

import CSS as CSS
import App.Component.Page.Home.Style.Card.Card as Card
import App.Component.Page.Home.Style.Card.Line as Line
import App.Component.Page.Home.Style.Card.Names as Names
import App.Component.Page.Home.Style.Card.Portrait as Portrait

style :: CSS.CSS
style = do
  Card.style
  Portrait.style
  Names.style
  Line.style