module Ui.Component.Common.Timeline.Component
  ( component
  , timeline
  )
  where

import Proem

import Ui.Component.Common.Timeline.HandleAction.HandleAction (handleAction)
import Ui.Component.Common.Timeline.Render (render)
import Ui.Component.Common.Timeline.Type (Action(..), Input, Output, Query)
import Ui.Util.Capability.AppM (AppM)
import Data.Array (nubByEq)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: ∀ w i. Component Query (Input w i) Output AppM
component = mkComponent
  { initialState: \input ->
      let
        items = input.items # nubByEq (\a b -> a.date == b.date)
      in
        { input: input { items = items }
        , selectedItem: Nothing
        , scrollFork: Nothing
        }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , receive = Just ◁ Receive
      , initialize = Just Initialize
      }
  }

timeline 
  :: ∀ action slots label slotAddressIndex slots' w i
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input w i
  -> (Output -> action)
  -> ComponentHTML action slots AppM
timeline _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    outputAction