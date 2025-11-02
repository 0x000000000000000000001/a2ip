module App.Component.Router.Type where

import App.Component.Page.Home.Type as PageHome
import App.Component.Page.About.Type as PageAbout
import App.Component.Page.Seminars.Type as PageSeminars
import App.Component.Router.Menu.Type as Menu
import App.Component.Util.Type (NoInput, NoOutput, NoSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import App.Util.Capability.Navigate (Route)
import Data.Maybe (Maybe)
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
  , scrollFork :: Maybe ForkId
  }

data Action 
  = Initialize
  | HandleDocScroll
  | HandleDocScrollEnd

data Query a = Navigate Route a

type RouteM a = HalogenM State Action Slots Output AppM a

