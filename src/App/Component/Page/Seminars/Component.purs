module App.Component.Page.Seminars.Component where

import Proem

import App.Component.Page.Seminars.HandleAction (handleAction)
import App.Component.Page.Seminars.Render (render)
import App.Component.Page.Seminars.Type (Action(..), Input, Output, Query)
import App.Util.Capability.AppM (AppM)
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
  -> Input
  -> (Output -> action)
  -> ComponentHTML action slots AppM
seminars _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    outputAction