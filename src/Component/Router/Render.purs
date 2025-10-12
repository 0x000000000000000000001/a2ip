module Component.Router.Render where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Page.About.Component as PageAboutComponent
import Component.Router.Menu.Component as MenuComponent
import Component.Router.Route (Route(..))
import Component.Router.Style.Core as Core
import Component.Router.Style.Router (classId)
import Component.Router.Style.Sheet (sheet)
import Component.Router.Type (Action, Slots, State, about, menu)
import Component.Util.Type (noInput, noOutputAction, noSlotAddressIndex)
import Halogen (ComponentHTML)
import Halogen.HTML (div, slot, text)
import Util.Style (class_)

render :: State -> ComponentHTML Action Slots AppM
render { route } =
  div
    [ class_ classId ] 
    [ sheet
    , slot menu noSlotAddressIndex MenuComponent.component noInput noOutputAction
    , div
        [ class_ Core.classId ]
        [ case route of
            Home -> div [] [ text "🏠 Page d'accueil" ]
            About -> slot about noSlotAddressIndex PageAboutComponent.component noInput noOutputAction
        ]
    ]
