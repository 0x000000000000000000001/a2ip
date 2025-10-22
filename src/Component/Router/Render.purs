module Component.Router.Render where

import Proem hiding (div)

import Capability.AppM (AppM)
import Component.Page.About.Component as PageAbout
import Component.Page.Seminars.Component as PageSeminars
import Component.Router.Menu.Component as Menu
import Component.Router.Route (Route(..))
import Component.Router.Style.Core as Core
import Component.Router.Style.Router (classId)
import Component.Router.Style.Sheet (sheet)
import Component.Router.Type (Action, Slots, State, about, menu, seminars)
import Component.Util.Type (noInput, noOutputAction, noSlotAddressIndex)
import Halogen (ComponentHTML)
import Halogen.HTML (div, main, slot, text)
import Util.Style (class_)

render :: State -> ComponentHTML Action Slots AppM
render { route } =
  div
    [ class_ classId ]
    [ sheet
    , slot menu noSlotAddressIndex Menu.component noInput noOutputAction
    , main
        [ class_ Core.classId ]
        [ case route of
            Home -> div [] [ text "🏠 Page d'accueil" ]
            Seminars -> slot seminars noSlotAddressIndex PageSeminars.component noInput noOutputAction
            About -> slot about noSlotAddressIndex PageAbout.component noInput noOutputAction
        ]
    ]
