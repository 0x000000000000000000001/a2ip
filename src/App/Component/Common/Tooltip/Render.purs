module App.Component.Common.Tooltip.Render
  ( render
  ) where

import App.Component.Common.Tooltip.Style.Sheet (sheet)
import App.Component.Common.Tooltip.Style.Tooltip (classId, classIdWhenOpen)
import App.Component.Common.Tooltip.Type (Action, Slots, State)
import App.Util.Capability.AppM (AppM)
import Halogen (ComponentHTML)
import Halogen.HTML (div)
import Proem ((?), (↔))
import Util.Style (classes)

render 
  :: ∀ action slots w i
   . State action slots w i
  -> ComponentHTML (Action action slots w i) Slots AppM
render { open, input: { inner, outer } } = 
  div 
    ( [ classes [ classId, open ? classIdWhenOpen ↔ "" ] ]
      -- <> (open ? [ onMouseOver HandleMouseOver ] ↔ [])    
    )
    [ sheet
    , inner
    , outer
    ]
