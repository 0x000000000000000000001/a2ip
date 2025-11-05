module App.Component.Common.Fragment.Component
  ( component
  , fragment
  )
  where

import Proem

import App.Component.Common.Fragment.HandleAction (handleAction)
import App.Component.Common.Fragment.Type (Action(..), Input, Output, Query)
import App.Component.Util.Type (noOutputAction)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)
import Unsafe.Coerce (unsafeCoerce)

component :: ∀ w i. Component Query (Input w i) Output AppM
component = mkComponent
  { initialState: \html -> html
  , render: unsafeCoerce
  , eval:
      mkEval 
      defaultEval 
      { handleAction = handleAction
      , receive = Just ◁ Receive
      }
  }

fragment 
  :: ∀ action slots label slotAddressIndex slots' w i
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input w i
  -> ComponentHTML action slots AppM
fragment _slotLabel slotAddressIndex input = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    noOutputAction