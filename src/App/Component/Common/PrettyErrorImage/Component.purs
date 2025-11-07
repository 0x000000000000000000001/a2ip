module App.Component.Common.PrettyErrorImage.Component
  ( component
  , prettyErrorImage
  )
  where

import Proem

import App.Component.Common.PrettyErrorImage.HandleAction (handleAction)
import App.Component.Common.PrettyErrorImage.Render (render)
import App.Component.Common.PrettyErrorImage.Type (Action(..), Input, Output, Query, Try(..))
import App.Component.Util.Type (mkInput, noOutputAction)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: ∀ u. Component Query (Input u) Output AppM
component = mkComponent
  { initialState: mkInput \input ->
      { input 
      , try: FirstTry input.sources.first
      }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , receive = Just ◁ Receive
      }
  }

prettyErrorImage 
  :: ∀ action slots label slotAddressIndex slots' u
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input u
  -> ComponentHTML action slots AppM
prettyErrorImage _slotLabel slotAddressIndex input = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    noOutputAction