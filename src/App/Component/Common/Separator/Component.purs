module App.Component.Common.Separator.Component
  ( component
  , separator
  )
  where

import Proem

import App.Component.Common.Separator.HandleAction (handleAction)
import App.Component.Common.Separator.Render (render)
import App.Component.Common.Separator.Type (Action(..), Input, Output, Query)
import App.Util.Capability.AppM (AppM)
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
  -> (Output -> action)
  -> ComponentHTML action slots AppM
separator _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    outputAction