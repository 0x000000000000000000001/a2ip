module App.Component.Page.Home.Component where

import App.Component.Page.Home.HandleAction (handleAction)
import App.Component.Page.Home.Render (render)
import App.Component.Page.Home.Type (Input, Query, Output)
import App.Util.Capability.AppM (AppM)
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Proem (κ)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ
      { showModal: false
      }
  , render
  , eval: mkEval defaultEval 
      { handleAction = handleAction 
      }
  }

home 
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input
  -> (Output -> action)
  -> ComponentHTML action slots AppM
home _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    outputAction