module Component.Menu.Type
  ( Action(..)
  , Input
  , Output
  , State
  ) where

import Prelude (Unit, Void)
import Router.Routes (Route)

type State = { isUnfold :: Boolean }

data Action 
  = ToggleFolding Boolean
  | NavigateToRoute Route
  | Log String

type Input = Unit

type Output = Void