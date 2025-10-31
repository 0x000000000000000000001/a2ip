module App.Component.Common.Modal.Component
  ( component
  , modal
  )
  where

import Proem

import App.Component.Common.Modal.HandleAction (handleAction)
import App.Component.Common.Modal.Render (render)
import App.Component.Common.Modal.Type (Action(..), Input, Output)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component
  :: ∀ q i o. Component q i o AppM
  -> Component q (Input i) (Output o) AppM
component innerComponent = mkComponent
  { initialState: \input -> 
      { closable: input.closable 
      , innerInput: input.innerInput
      }
  , render: render innerComponent
  , eval: 
      mkEval 
      defaultEval 
      { handleAction = handleAction
      , receive = Just ◁ Receive 
      }
  }

modal 
  :: ∀ action slots label slotAddressIndex slots' query input output
   . Cons label (Slot query (Output output) slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Component query input output AppM
  -> Proxy label
  -> slotAddressIndex
  -> Input input
  -> (Output output -> action)
  -> ComponentHTML action slots AppM
modal innerComponent _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    (component innerComponent)
    input
    outputAction