module App.Component.Page.Home.Style.Sheet
  ( sheet
  ) where

import Proem

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import App.Component.Page.Home.Style.Home as Home
import App.Component.Page.Home.Style.Collaborators as Collaborators
import App.Component.Page.Home.Style.Members as Members
import App.Component.Page.Home.Style.Card.Index as Card 

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  Home.style  
  Collaborators.style  
  Members.style  
  Card.style 