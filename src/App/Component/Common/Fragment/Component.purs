module App.Component.Common.Fragment.Component
  ( component
  ) where

import Proem

import App.Component.Common.Fragment.HandleAction (handleAction)
import App.Component.Common.Fragment.Type (Action(..), Input, Output, Query, Slots)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, ComponentHTML, defaultEval, mkComponent, mkEval)
import Halogen.HTML as HH
import Unsafe.Coerce (unsafeCoerce)

component :: ∀ w i. Component Query (Input w i) Output AppM
component = mkComponent
  { initialState: \html -> { html }
  , render
  , eval:
      mkEval 
      defaultEval 
      { handleAction = handleAction
      , receive = Just ◁ Receive
      }
  }
  where
    render :: ∀ w' i'. { html :: Input w' i' } -> ComponentHTML (Action w' i') Slots AppM
    render state = HH.div_ [ unsafeCoerce state.html ]