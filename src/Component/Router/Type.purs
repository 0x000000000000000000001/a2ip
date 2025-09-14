module Component.Router.Type where

import Prelude

import Component.Router.Route (Route)
import Data.Const (Const)
import Halogen (Slot)

type Slots = 
  ( menu :: Slot (Const Void) Void Unit
  )

type State = { route :: Route }

data Action

data Query a = Navigate Route a
