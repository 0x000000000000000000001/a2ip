module App.Component.Common.Tooltip.Render
  ( render
  ) where

import App.Component.Common.Tooltip.Style.Tooltip (classId, classIdWhenOpen)
import Proem ((?), (↔))

import App.Component.Common.Tooltip.HandleInnerOutput (handleInnerOutput)
import App.Component.Common.Tooltip.Type (Action, Slots, State)
import App.Component.Util.Type (noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Halogen (Component, ComponentHTML)
import Halogen.HTML (div, slot)
import Util.Proxy.Dictionary.Inner (inner')
import Util.Style (classes)

render 
  :: ∀ q i o
   . Component q i o AppM
  -> State i
  -> ComponentHTML (Action i o) (Slots q o) AppM
render innerComponent { open, input: { innerInput } } = 
  div 
    ( [ classes [ classId, open ? classIdWhenOpen ↔ "" ] ]
      -- <> (open ? [ onMouseOver HandleMouseOver ] ↔ [])    
    )
    [ slot
        inner'
        noSlotAddressIndex
        innerComponent
        innerInput
        handleInnerOutput
    ]
