module Component.Common.Link.Type
  ( Action(..)
  , ComponentM
  , Input
  , Output(..)
  , Query
  , Slots
  , State
  , defaultInput
  )
  where

import CSS (Display, inlineBlock)
import Capability.AppM (AppM)
import Component.Router.Route (Route(..))
import Component.Util.Type (Children, NoQuery, NoSlots)
import Data.Maybe (Maybe(..))
import Halogen (HalogenM)
import Web.UIEvent.MouseEvent (MouseEvent)

type Input =
  { route :: Maybe Route
  , class_ :: Maybe String
  , display :: Display
  , children :: Children Action Slots
  } 

defaultInput :: Input
defaultInput = 
  { route: Just Home 
  , class_: Nothing 
  , display: inlineBlock
  , children: []
  }
 
data Output = Clicked Route MouseEvent

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State =
  { route :: Maybe Route
  , class_ :: Maybe String
  , display :: Display
  , children :: Children Action Slots
  }

data Action 
  = Navigate Route 
  | Receive Input
  | HandleClick Route MouseEvent

type Query :: ∀ k. k -> Type
type Query = NoQuery

type ComponentM a = HalogenM State Action Slots Output AppM a
