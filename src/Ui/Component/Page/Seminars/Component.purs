module Ui.Component.Page.Seminars.Component where

import Proem

import Ui.Component.Page.Seminars.HandleAction (handleAction)
import Ui.Component.Page.Seminars.Render (render)
import Ui.Component.Page.Seminars.Type (Action(..), Input, Output, Query)
import Ui.Component.Util.Type (noInput, noOutputAction)
import Ui.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Network.RemoteData (RemoteData(..))
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ NotAsked
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , initialize = Just Load
      }
  }

seminars 
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> ComponentHTML action slots AppM
seminars _slotLabel slotAddressIndex = 
  slot
    _slotLabel
    slotAddressIndex
    component
    noInput
    noOutputAction