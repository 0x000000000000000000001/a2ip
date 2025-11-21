module App.Component.Page.Home.Component where

import Proem

import App.Component.Page.Home.HandleAction (handleAction)
import App.Component.Page.Home.Render (render)
import App.Component.Page.Home.Type (Input, Query, Output)
import App.Component.Util.Type (noInput, noOutputAction)
import App.Util.Capability.AppM (AppM)
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ
      { showModal: false
      , innerClicks: 0
      , outerClicks: 0
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
  -> ComponentHTML action slots AppM
home _slotLabel slotAddressIndex = 
  slot
    _slotLabel
    slotAddressIndex
    component
    noInput
    noOutputAction