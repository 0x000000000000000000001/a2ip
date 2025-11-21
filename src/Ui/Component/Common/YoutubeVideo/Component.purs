module Ui.Component.Common.YoutubeVideo.Component
  ( component
  , youtubeVideo
  )
  where

import Proem

import Ui.Component.Common.YoutubeVideo.HandleAction (handleAction)
import Ui.Component.Common.YoutubeVideo.Render (render)
import Ui.Component.Common.YoutubeVideo.Type (Action(..), Output, Query, Input)
import Ui.Component.Util.Type (withId, noOutputAction)
import Ui.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, ComponentHTML, Slot, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: withId \input -> { input }
  , render
  , eval: mkEval defaultEval
    { handleAction = handleAction
    , receive = Just ◁ Receive
    , initialize = Just Initialize
    }
  }

youtubeVideo 
  :: ∀ action slots label slotAddressIndex slots'
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input
  -> ComponentHTML action slots AppM
youtubeVideo _slotLabel slotAddressIndex input = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    noOutputAction