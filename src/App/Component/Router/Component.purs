module App.Component.Router.Component where

import Proem

import App.Component.Router.HandleAction (handleAction)
import App.Component.Router.HandleQuery (handleQuery)
import App.Component.Router.Render (render)
import App.Component.Router.Type (Action(..), Input, Output, Query)
import App.Util.Capability.AppM (AppM)
import App.Util.Capability.Navigate (Route(..))
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ
      { route: Home 
      , scrollFork: Nothing
      }
  , render
  , eval: mkEval defaultEval  
      { handleAction = handleAction 
      , handleQuery = handleQuery
      , initialize = Just Initialize
      }
  } 

router 
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input
  -> (Output -> action)
  -> ComponentHTML action slots AppM
router _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    outputAction