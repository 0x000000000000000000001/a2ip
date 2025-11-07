module App.Component.Router.Render where

import Proem hiding (div)

import App.Component.Page.About.Component (about)
import App.Component.Page.Home.Component (home)
import App.Component.Page.Seminars.Component (seminars)
import App.Component.Router.Menu.Component (menu)
import App.Component.Router.Style.Core as Core
import App.Component.Router.Style.Router (classId)
import App.Component.Router.Style.Sheet (sheet)
import App.Component.Router.Type (Action, Slots, State)
import App.Component.Util.Type (noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import App.Util.Capability.Navigate (Route(..))
import Halogen (ComponentHTML)
import Halogen.HTML (div, main)
import Util.Proxy.Dictionary.About (about')
import Util.Proxy.Dictionary.Home (home')
import Util.Proxy.Dictionary.Menu (menu')
import Util.Proxy.Dictionary.Seminars (seminars')
import Util.Style.Style (class_)

render :: State -> ComponentHTML Action Slots AppM
render { route } =
  div
    [ class_ classId ]
    [ sheet
    , menu menu' noSlotAddressIndex 
    , main
        [ class_ Core.classId ]
        [ case route of
            Home -> home home' noSlotAddressIndex
            About -> about about' noSlotAddressIndex
            Seminars -> seminars seminars' noSlotAddressIndex
        ]
    ]
