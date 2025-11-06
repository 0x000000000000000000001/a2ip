module App.Component.Common.Tooltip.HandleInnerOutput
  ( handleInnerOutput
  ) where


import App.Component.Common.Tooltip.Type (Action(..))

handleInnerOutput :: ∀ i o. o -> Action i o
handleInnerOutput output = RaiseInnerOutput output
  
