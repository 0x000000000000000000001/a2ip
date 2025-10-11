module Component.Common.Link.Type
  ( Action(..)
  , Input
  , Output
  , Query
  , Slots
  , State
  , defaultInput
  )
  where

import CSS (Display, inlineBlock)
import Component.Router.Route (Route(..))
import Component.Util.Type (NoOutput, NoQuery, NoSlots, Children)
import Data.Maybe (Maybe(..))
import Web.Event.Internal.Types (Event)
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
 
type Output = NoOutput

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
  | HandleClick (Maybe Route) MouseEvent

type Query :: ∀ k. k -> Type
type Query = NoQuery