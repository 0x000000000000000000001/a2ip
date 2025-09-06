module Component.Menu.Type
  ( Action(..)
  , Input
  , Output
  , State
  ) where

import Prelude (Unit, Void)

type State = { isUnfold :: Boolean }

data Action = ToggleFolding Boolean

type Input = Unit

type Output = Void