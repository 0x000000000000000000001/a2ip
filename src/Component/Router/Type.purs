module Component.Router.Type where

import Prelude

import Component.Page.About.Type as PageAboutType
import Component.Router.Route (Route)
import Data.Const (Const)
import Halogen (Slot)

type Slots =
  ( menu :: Slot (Const Void) Void Unit
  , about :: Slot PageAboutType.Query Void Unit
  )

type State = { route :: Route }

data Action

data Query a = Navigate Route a
