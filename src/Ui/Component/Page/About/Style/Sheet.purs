module App.Component.Page.About.Style.Sheet
  ( sheet
  ) where

import Proem

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Page.About.Style.About as About
import App.Component.Page.About.Style.Collaborators as Collaborators
import App.Component.Page.About.Style.Members as Members
import App.Component.Page.About.Style.Card.Index as Card 

sheet :: ∀ w i. HTML w i
sheet = stylesheet do
  About.style  
  Collaborators.style  
  Members.style  
  Card.style 