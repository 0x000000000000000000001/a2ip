module App.Component.Router.Render where

import Proem hiding (div)

import App.Component.Page.About.Component as PageAbout
import App.Component.Page.Seminars.Component as PageSeminars
import App.Component.Router.Menu.Component as Menu
import App.Component.Router.Style.Core as Core
import App.Component.Router.Style.Router (classId)
import App.Component.Router.Style.Sheet (sheet)
import App.Component.Router.Type (Action, Slots, State, about, menu, seminars)
import App.Component.Util.Type (noInput, noOutputAction, noSlotAddressIndex)
import App.Util.Capability.AppM.AppM (AppM)
import App.Util.Capability.Navigate (Route(..))
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
