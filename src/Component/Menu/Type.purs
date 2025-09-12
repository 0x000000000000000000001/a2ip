module Component.Menu.Type
  ( Action(..)
  , Input
  , Output
  , State
  ) where

import Prelude (Unit, Void)
import Route (Route)

type State = { isUnfold :: Boolean }

data Action 
  = ToggleFolding Boolean
  | NavigateToRoute Route

type Input = Unit

type Output = Void