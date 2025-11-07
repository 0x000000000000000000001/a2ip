module App.Component.Common.YoutubeVideo.Component
  ( component
  , youtubeVideo
  )
  where

import Proem

import App.Component.Common.YoutubeVideo.HandleAction (handleAction)
import App.Component.Common.YoutubeVideo.Render (render)
import App.Component.Common.YoutubeVideo.Type (Action(..), Output, Query, Input)
import App.Component.Util.Type (mkInput, noOutputAction)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Halogen (Component, ComponentHTML, Slot, defaultEval, mkComponent, mkEval)
import Halogen.HTML (slot)
import Prim.Row (class Cons)
import Type.Prelude (Proxy)

component :: ∀ u. Component Query (Input u) Output AppM
component = mkComponent
  { initialState: mkInput \input -> { input }
  , render
  , eval: mkEval defaultEval
    { handleAction = handleAction
    , receive = Just ◁ Receive
    , initialize = Just Initialize
    }
  }

youtubeVideo 
  :: ∀ action slots label slotAddressIndex slots' u
   . Cons label (Slot Query Output slotAddressIndex) slots' slots
  => IsSymbol label
  => Ord slotAddressIndex
  => Proxy label
  -> slotAddressIndex
  -> Input u
  -> ComponentHTML action slots AppM
youtubeVideo _slotLabel slotAddressIndex input = 
  slot
    _slotLabel
    slotAddressIndex
    component
    input
    noOutputAction