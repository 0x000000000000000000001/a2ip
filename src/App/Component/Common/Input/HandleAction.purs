module App.Component.Common.Input.HandleAction
  ( handleAction
  )
  where

import Proem

import App.Component.Common.Input.Type (Action(..), InputM, Output(..))
import Halogen (modify_, raise)

handleAction :: Action -> InputM Unit
handleAction = case _ of
  Receive input -> modify_ _ { input = input }
  
  HandleInput newValue -> do
    modify_ _ { value = newValue }
    raise $ ChangedValue newValue
