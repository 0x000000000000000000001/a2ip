module Component.Router.Render where

import Prelude hiding (div)

import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Page.About.Component as PageAboutComponent
import Component.Router.Menu.Component as MenuComponent
import Component.Router.Route (Route(..))
import Component.Router.Type (Action, State, Slots)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (div, slot, text)
import Type.Proxy (Proxy(..))
import Utils.Style (class_)
import Component.Router.Style.Router (classId)
import Component.Router.Style.Sheet (sheet)
import Component.Router.Style.Core as Core

render :: forall m. MonadAff m => Navigate m => Log m => State -> H.ComponentHTML Action Slots m
render { route } =
  div
    [ class_ classId ]
    [ sheet
    , slot (Proxy :: Proxy "menu") unit MenuComponent.component unit absurd
    , div
        [ class_ Core.classId ]
        [ case route of
            Home -> div [] [ text "🏠 Page d'accueil" ]
            About -> slot (Proxy :: Proxy "about") unit PageAboutComponent.component unit absurd
        ]
    ]
