module Component.Page.About.Style.Sheet
  ( sheet
  ) where

import Proem

import Halogen.HTML (HTML)
import Halogen.HTML.CSS (stylesheet)
import Component.Page.About.Style.About as About
import Component.Page.About.Style.Collaborator as Collaborator
import Component.Page.About.Style.Collaborators as Collaborators
import Component.Page.About.Style.Members as Members
import Component.Page.About.Style.Card.Index as Card 

sheet :: ∀ p i. HTML p i
sheet = stylesheet do
  About.style  
  Collaborator.style  
  Collaborators.style  
  Members.style  
  Card.style 