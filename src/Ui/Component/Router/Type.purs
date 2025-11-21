module Ui.Component.Router.Type where

import Ui.Component.Page.About.Type as PageAbout
import Ui.Component.Page.Home.Type as PageHome
import Ui.Component.Page.Seminars.Type as PageSeminars
import Ui.Component.Router.Menu.Type as Menu
import Ui.Component.Util.Type (NoInput, NoOutput, NoSlotAddressIndex)
import Ui.Util.Capability.AppM (AppM)
import Ui.Util.Capability.Navigate (Route)
import Data.Maybe (Maybe)
import Effect.Ref (Ref)
import Halogen (HalogenM, Slot)
import Halogen.Query (ForkId)

type Slots =
  ( menu :: Slot Menu.Query Menu.Output NoSlotAddressIndex
  , home :: Slot PageHome.Query PageHome.Output NoSlotAddressIndex
  , about :: Slot PageAbout.Query PageAbout.Output NoSlotAddressIndex
  , seminars :: Slot PageSeminars.Query PageSeminars.Output NoSlotAddressIndex
  )

type Input = NoInput

type Output = NoOutput

type State = 
  { route :: Route 
  , scrollFork :: Maybe (Ref (Maybe ForkId))
  }

data Action 
  = Initialize
  | HandleDocScroll
  | HandleDocScrollEnd

data Query a = Navigate Route a

type RouteM a = HalogenM State Action Slots Output AppM a

