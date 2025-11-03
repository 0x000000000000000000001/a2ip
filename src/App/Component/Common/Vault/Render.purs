module App.Component.Common.Vault.Render
  ( render
  ) where

import Proem hiding (div)

import App.Component.Common.Vault.HandleInnerOutput (handleInnerOutput)
import App.Component.Common.Vault.Style.Core as Core
import App.Component.Common.Vault.Style.Vault (classId)
import App.Component.Common.Vault.Style.Sheet (sheet)
import App.Component.Common.Vault.Type (Action, Slots, State)
import App.Component.Util.Type (noSlotAddressIndex)
import App.Util.Capability.AppM (AppM)
import Halogen (Component, ComponentHTML)
import Halogen.HTML (div, slot)
import Util.Proxy.Dictionary.Inner (inner')
import Util.Style (class_)

render 
  :: ∀ q i o
   . Component q i o AppM
  -> State i
  -> ComponentHTML (Action i o) (Slots q o) AppM
render innerComponent s = 
  div 
    [ class_ classId
    ]
    [ sheet
    , div 
        [ class_ Core.classId ]
        [ slot
            inner'
            noSlotAddressIndex
            innerComponent
            s.innerInput
            handleInnerOutput
        ]
    ]
