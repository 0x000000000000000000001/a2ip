module Component.Common.Link.Type
  ( Action(..)
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import Component.Router.Route (Route)
import Component.Util.Type (NoOutput, NoQuery, NoSlots, Children)
import Data.Maybe (Maybe)

type Input =
  { route :: Maybe Route
  , class_ :: String
  , children :: Children Action Slots
  } 
 
type Output = NoOutput

type Slots :: ∀ k. Row k
type Slots = NoSlots

type State =
  { route :: Maybe Route
  , class_ :: String
  , children :: Children Action Slots
  }

data Action 
  = Navigate Route 
  | Receive Input

type Query :: ∀ k. k -> Type
type Query = NoQuery