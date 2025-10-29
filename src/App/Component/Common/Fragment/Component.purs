module App.Component.Common.Fragment.Component
  ( component
  ) where

import Proem

import App.Component.Common.Fragment.HandleAction (handleAction)
import App.Component.Common.Fragment.Type (Action(..), Input, Output, Query)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Unsafe.Coerce (unsafeCoerce)

component :: ∀ w i. Component Query (Input w i) Output AppM
component = mkComponent
  { initialState: κ
  , render: unsafeCoerce
  , eval:
      mkEval 
      defaultEval 
      { handleAction = unsafeCoerce handleAction
      , receive = Just ◁ Receive
      }
  }