module Component.Common.Link.Type
  ( Action(..)
  , Input
  , Output(..)
  , Query
  , Slots
  , State
  , defaultInput
  )
  where

import CSS (Display, inlineBlock)
import Component.Router.Route (Route(..))
import Component.Util.Type (Children, NoQuery, NoSlots)
import Data.Maybe (Maybe(..))
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
 
data Output = Clicked Route

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