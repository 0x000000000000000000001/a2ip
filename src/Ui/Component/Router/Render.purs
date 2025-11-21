module Ui.Component.Router.Render where

import Proem hiding (div)

import Ui.Component.Page.About.Component (about)
import Ui.Component.Page.Home.Component (home)
import Ui.Component.Page.Seminars.Component (seminars)
import Ui.Component.Router.Menu.Component (menu)
import Ui.Component.Router.Style.Core (core_)
import Ui.Component.Router.Style.Router (router_)
import Ui.Component.Router.Style.Sheet (sheet)
import Ui.Component.Router.Type (Action, Slots, State)
import Ui.Component.Util.Type (noSlotAddressIndex)
import Ui.Util.Capability.AppM (AppM)
import Ui.Util.Capability.Navigate (Route(..))
import Halogen (ComponentHTML)
import Util.Proxy.Dictionary.About (about')
import Util.Proxy.Dictionary.Home (home')
import Util.Proxy.Dictionary.Menu (menu')
import Util.Proxy.Dictionary.Seminars (seminars')

render :: State -> ComponentHTML Action Slots AppM
render { route } =
  router_
    [ sheet
    , menu menu' noSlotAddressIndex 
    , core_
        [ case route of
            Home -> home home' noSlotAddressIndex
            About -> about about' noSlotAddressIndex
            Seminars -> seminars seminars' noSlotAddressIndex
        ]
    ]
