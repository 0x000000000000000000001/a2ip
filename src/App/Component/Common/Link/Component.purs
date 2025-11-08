module App.Component.Common.Link.Component
  ( component
  , link
  )
  where

import Proem

import App.Component.Common.Link.HandleAction (handleAction)
import App.Component.Common.Link.Render (render)
import App.Component.Common.Link.Type (Action(..), Input, Output, Query)
import App.Component.Util.Type (mkInput)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Input Output AppM
component = mkComponent
    { initialState: mkInput \input -> { input }
    , render   
    , eval: mkEval defaultEval
        { handleAction = handleAction
        , receive = Just ◁ Receive
        }
    }

link 
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input
  -> (Output -> action)
  -> ComponentHTML action slots AppM
link _slotLabel slotAddressIndex input outputAction = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    outputAction