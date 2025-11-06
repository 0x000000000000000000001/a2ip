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
  :: ∀ w i
   . State w i
  -> ComponentHTML (Action w i) Slots AppM
render { open, input: { inner, outer, outerPosition } } = 
  div 
    ( [ classes [ classId, open ? classIdWhenOpen ↔ "" ] ]
      -- <> (open ? [ onMouseOver HandleMouseOver ] ↔ [])    
    )
    [ inner
    , outer
    ]
