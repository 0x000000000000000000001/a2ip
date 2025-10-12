module Component.Router.Type where

import Component.Page.About.Type as PageAbout
import Component.Router.Menu.Type as Menu
import Component.Router.Route (Route)
import Component.Util.Type (NoAction, NoInput, NoOutput, NoSlotAddressIndex)
import Halogen (Slot)
import Type.Prelude (Proxy(..))

type Slots =
  ( menu :: Slot Menu.Query Menu.Output NoSlotAddressIndex
  , about :: Slot PageAbout.Query PageAbout.Output NoSlotAddressIndex
  )

type Input = NoInput

type Output = NoOutput

type State = { route :: Route }

type Action = NoAction

data Query a = Navigate Route a

menu = Proxy :: Proxy "menu"
about = Proxy :: Proxy "about"
