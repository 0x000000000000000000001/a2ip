module Component.Router.Menu.Type
  ( Action(..)
  , Input
  , Output
  , Query
  , Slots
  , State
  )
  where

import Component.Router.Route (Route)
import Component.Util.Type (NoInput, NoQuery, NoSlots, NoOutput)

type Slots :: forall k. Row k
type Slots = NoSlots

type State = { isUnfold :: Boolean }

data Action 
  = ToggleFolding Boolean
  | Navigate Route

type Input = NoInput

type Output = NoOutput

type Query :: forall k. k -> Type
type Query = NoQuery