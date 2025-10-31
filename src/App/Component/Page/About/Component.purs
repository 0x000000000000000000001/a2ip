module App.Component.Page.About.Component where

import Proem

import App.Component.Page.About.HandleAction (handleAction)
import App.Component.Page.About.Render (render)
import App.Component.Page.About.Type (Action(..), Input, Query, Output)
import App.Component.Util.Type (noInput, noOutputAction)
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
  { initialState: κ
      { members: NotAsked
      , collaborators: NotAsked
      }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , initialize = Just Load
      } 
  }

about 
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> ComponentHTML action slots AppM
about _slotLabel slotAddressIndex = 
  slot
    _slotLabel
    slotAddressIndex
    component
    noInput
    noOutputAction