module App.Component.Common.Fragment.Component
  ( component
  ) where

import Proem

import App.Component.Common.Fragment.HandleAction (handleAction)
import App.Component.Common.Fragment.Render (render)
import App.Component.Common.Fragment.Type (Input, Output, Query)
import App.Util.Capability.AppM (AppM)
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Unsafe.Coerce (unsafeCoerce)

component :: ∀ w i. Component Query (Input w i) Output AppM
component = mkComponent
  { initialState: κ
  , render
  , eval:
      mkEval 
      defaultEval 
      { handleAction = handleAction
      }
  }