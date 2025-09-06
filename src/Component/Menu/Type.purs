module Component.Menu.Type
  ( Action(..)
  , Input
  , Output
  , State
  ) where

import Prelude (Void)

type State = { isUnfold :: Boolean }

data Action = ToggleFolding Boolean

type Input = Void

type Output = Void