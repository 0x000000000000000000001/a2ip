module App.Component.Common.Timeline.Component
  ( component
  , timeline
  )
  where

import Proem

import App.Component.Common.Timeline.HandleAction.HandleAction (handleAction)
import App.Component.Common.Timeline.Render (render)
import App.Component.Common.Timeline.Type (Action(..), Input, Output, Query)
import App.Util.Capability.AppM (AppM)
import Data.Array (nubEq)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: \input ->
      let
        dates = input.dates # nubEq
      in
        { input: input { dates = dates }
        , selectedDate: Nothing
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
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input
  -> (Output -> action)
  -> ComponentHTML action slots AppM
timeline _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    outputAction