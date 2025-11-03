module App.Component.Common.Input.HandleAction
  ( handleAction
  ) where

import Proem

import App.Component.Common.Input.Type (Action(..), InputM, Output(..))
import Data.Maybe (Maybe(..))
import Data.Traversable (for_)
import Effect.Ref (new, write)
import Halogen (get, modify_, raise)

handleAction :: Action -> InputM Unit
handleAction = case _ of
  Initialize -> do
    state <- get

    ref <- ʌ $ new state.input.initialValue

    modify_ _ { value = Just ref }

  Receive input -> modify_ _ { input = input }

  HandleInput newValue -> do
    state <- get

    for_
      state.value
      \ref -> ʌ $ write newValue ref

    raise $ ChangedValue newValue
