module App.Component.Common.Input.Component
  ( component
  , input
  )
  where

import Proem

import App.Component.Common.Input.HandleAction (handleAction)
import App.Component.Common.Input.Render (render)
import App.Component.Common.Input.Type (Action(..), Input, Output, Query)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Input Output AppM
component = mkComponent
    { initialState: \i -> 
        { input: i
        , value: Nothing
        }
    , render   
    , eval: mkEval defaultEval
        { handleAction = handleAction
        , receive = Just ◁ Receive
        }
    }

input 
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input
  -> (Output -> action)
  -> ComponentHTML action slots AppM
input _slotLabel slotAddressIndex input' outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input'
    outputAction
