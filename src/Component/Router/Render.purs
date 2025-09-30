module Component.Router.Render where

import Prelude hiding (div)

import Capability.AppM (AppM)
import Component.Page.About.Component as PageAboutComponent
import Component.Router.Menu.Component as MenuComponent
import Component.Router.Route (Route(..))
import Component.Router.Style.Core as Core
import Component.Router.Style.Router (classId)
import Component.Router.Style.Sheet (sheet)
import Component.Router.Type (Action, State, Slots)
import Halogen as H
import Halogen.HTML (div, slot, text)
import Type.Proxy (Proxy(..))
import Utils.Style (class_)

render :: State -> H.ComponentHTML Action Slots AppM
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
