module Component.Router.Type where

import Prelude

import Component.Page.About.Type as PageAboutType
import Component.Router.Route (Route)
import Component.Util.Type (NoAction, NoInput, NoOutput)
import Data.Const (Const)
import Halogen (Slot)

type Slots =
  ( menu :: Slot (Const Void) Void Unit
  , about :: Slot PageAboutType.Query Void Unit
  )

type Input = NoInput

type Output = NoOutput

type State = { route :: Route }

type Action = NoAction

data Query a = Navigate Route a
