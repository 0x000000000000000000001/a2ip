module Ui.Component.Common.Carrousel.Component
  ( carrousel
  , component
  )
  where

import Proem

import Ui.Component.Common.Carrousel.HandleAction (handleAction)
import Ui.Component.Common.Carrousel.Render (render)
import Ui.Component.Common.Carrousel.Type (Action(..), Input, Output, Query)
import Ui.Component.Util.Type (withId)
import Ui.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: withId \input -> { input, index: 0 }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , receive = Just ◁ Receive
      }
  }

carrousel 
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input
  -> (Output -> action)
  -> ComponentHTML action slots AppM
carrousel _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    outputAction