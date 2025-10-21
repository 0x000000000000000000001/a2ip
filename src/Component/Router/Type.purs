module Component.Router.Type where

import Capability.AppM (AppM)
import Component.Page.About.Type as PageAbout
import Component.Page.Seminars.Type as PageSeminars
import Component.Router.Menu.Type as Menu
import Component.Router.Route (Route)
import Component.Util.Type (NoAction, NoInput, NoOutput, NoSlotAddressIndex)
import Halogen (HalogenM, Slot)
import Type.Prelude (Proxy(..))

type Slots =
  ( menu :: Slot Menu.Query Menu.Output NoSlotAddressIndex
  , seminars :: Slot PageSeminars.Query PageSeminars.Output NoSlotAddressIndex
  , about :: Slot PageAbout.Query PageAbout.Output NoSlotAddressIndex
  )

menu = Proxy :: Proxy "menu"
seminars = Proxy :: Proxy "seminars"
about = Proxy :: Proxy "about"

type Input = NoInput

type Output = NoOutput

type State = { route :: Route }

type Action = NoAction

data Query a = Navigate Route a

type ComponentM a = HalogenM State Action Slots Output AppM a

