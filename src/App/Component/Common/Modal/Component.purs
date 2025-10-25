module App.Component.Common.Modal.Component
  ( component
  ) where

import Proem

import App.Component.Common.Modal.HandleAction (handleAction)
import App.Component.Common.Modal.Render (render)
import App.Component.Common.Modal.Type (Action(..), Input, Output)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component
  :: ∀ q i o. Component q i o AppM
  -> Component q (Input i) (Output o) AppM
component innerComponent = mkComponent
  { initialState: \input -> 
      { closable: input.closable 
      , innerInput: input.innerInput
      }
  , render: render innerComponent
  , eval: 
      mkEval 
      defaultEval 
      { handleAction = handleAction
      , receive = Just ◁ Receive 
      }
  }