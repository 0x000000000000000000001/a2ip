module Ui.Component.Router.Menu.Component
  ( component
  , menu
  )
  where

import Proem hiding (top, div)

import Ui.Component.Router.Menu.HandleAction (handleAction)
import Ui.Component.Router.Menu.Render (render)
import Ui.Component.Router.Menu.Type (Action(..), Output, Query)
import Ui.Component.Util.Type (withId, noInput, noOutputAction)
import Ui.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Unit Output AppM
component = mkComponent
  { initialState: withId $ κ { unfold: false, animating: false }
  , render
  , eval: mkEval defaultEval 
      { handleAction = handleAction
      , initialize = Just Initialize
      }
  } 

menu 
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> ComponentHTML action slots AppM
menu _slotLabel slotAddressIndex = 
  slot
    _slotLabel
    slotAddressIndex
    component
    noInput
    noOutputAction