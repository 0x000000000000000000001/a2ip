module Ui.Component.Common.PrettyErrorImage.Component
  ( component
  , prettyErrorImage
  )
  where

import Proem

import Ui.Component.Common.PrettyErrorImage.HandleAction (handleAction)
import Ui.Component.Common.PrettyErrorImage.Render (render)
import Ui.Component.Common.PrettyErrorImage.Type (Action(..), Input, Output, Query, Try(..))
import Ui.Component.Util.Type (withId, noOutputAction)
import Ui.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, Slot, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: withId \input ->
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
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input
  -> ComponentHTML action slots AppM
prettyErrorImage _slotLabel slotAddressIndex input = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    noOutputAction