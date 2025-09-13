module Component.Router.Render where

import Prelude hiding (div)

import Component.Router.Route (Route(..))
import Component.Router.Type (Action, State)
import Halogen as H
import Halogen.HTML (div, text)

render :: forall m. State -> H.ComponentHTML Action () m
render { route } =
  div []
    [ renderRoute route ]

renderRoute :: forall w i. Route -> H.ComponentHTML i () w
renderRoute = case _ of
  Home -> div [] [ text "🏠 Page d'accueil" ]
  About -> div [] [ text "ℹ️ À propos" ]
