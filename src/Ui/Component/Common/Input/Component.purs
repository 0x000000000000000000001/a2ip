module Ui.Component.Common.Input.Component
  ( component
  , input
  )
  where

import Proem

import Ui.Component.Common.Input.HandleAction (handleAction)
import Ui.Component.Common.Input.Render (render)
import Ui.Component.Common.Input.Type (Action(..), Input, Output, Query)
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
    { initialState: withId \i -> 
        { input: i
        , value: Nothing
        , open: false
        }
    , render   
    , eval: mkEval defaultEval
        { handleAction = handleAction
        , receive = Just ◁ Receive
        , initialize = Just Initialize
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
