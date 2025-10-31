module App.Component.Common.Fragment.Component
  ( component
  ) where

import Proem

import App.Component.Common.Fragment.HandleAction (handleAction)
import App.Component.Common.Fragment.Type (Action(..), Input, Output, Query)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)
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
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input
  -> (Output -> action)
  -> ComponentHTML action slots AppM
fragment _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    outputAction