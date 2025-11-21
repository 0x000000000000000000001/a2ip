module Ui.Component.Common.Modal.HandleInnerOutput
  ( handleInnerOutput
  ) where


import Ui.Component.Common.Modal.Type (Action(..))

handleInnerOutput :: ∀ i o. o -> Action i o
handleInnerOutput output = RaiseInnerOutput output
  
