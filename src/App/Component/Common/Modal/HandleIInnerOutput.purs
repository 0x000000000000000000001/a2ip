module App.Component.Common.Modal.HandleInnerOutput
  ( handleInnerOutput
  ) where


import App.Component.Common.Modal.Type (Action(..))

handleInnerOutput :: ∀ i o. o -> Action i o
handleInnerOutput output = RaiseInnerOutput output
  
