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
import Component.Util.Type (GenericInput, GenericQuery, GenericSlots, GenericOutput)

type Slots :: forall k. Row k
type Slots = GenericSlots

type State = { isUnfold :: Boolean }

data Action 
  = ToggleFolding Boolean
  | Navigate Route

type Input = GenericInput

type Output = GenericOutput

type Query :: forall k. k -> Type
type Query = GenericQuery