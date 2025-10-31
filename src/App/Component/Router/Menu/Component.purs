module App.Component.Router.Menu.Component
  ( component
  , menu
  )
  where

import Proem hiding (top, div)

import App.Component.Router.Menu.HandleAction (handleAction)
import App.Component.Router.Menu.Render (render)
import App.Component.Router.Menu.Type (Action(..), Input, Output, Query)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Unit Output AppM
component = mkComponent
  { initialState: κ { unfold: false, animating: false }
  , render
  , eval: mkEval defaultEval 
      { handleAction = handleAction
      , initialize = Just Initialize
      }
  } 

menu 
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input
  -> (Output -> action)
  -> ComponentHTML action slots AppM
menu _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    outputAction