module Ui.Component.Common.Separator.Component
  ( component
  , separator
  )
  where

import Proem

import Ui.Component.Common.Separator.HandleAction (handleAction)
import Ui.Component.Common.Separator.Render (render)
import Ui.Component.Common.Separator.Type (Action(..), Input, Output, Query)
import Ui.Component.Util.Type (noOutputAction)
import Ui.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Input Output AppM
component = mkComponent
    { initialState: \input -> { input }
    , render   
    , eval: mkEval defaultEval 
      { handleAction = handleAction
      , receive = Just ◁ Receive
      }
    }

separator 
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input
  -> ComponentHTML action slots AppM
separator _slotLabel slotAddressIndex input = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    noOutputAction