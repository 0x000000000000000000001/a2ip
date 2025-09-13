module Component.Menu.Type
  ( Action(..)
  , Input
  , Output
  , State
  ) where

import Prelude (Unit, Void)
import Component.Router.Route (Route)

type State = { isUnfold :: Boolean }

data Action 
  = ToggleFolding Boolean
  | Navigate Route

type Input = Unit

type Output = Void