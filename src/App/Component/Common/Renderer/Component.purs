module App.Component.Common.Renderer.Component
  ( component
  ) where

import Proem

import App.Component.Common.Renderer.HandleAction (handleAction)
import App.Component.Common.Renderer.Render (render)
import App.Component.Common.Renderer.Type (Input, Output, Query)
import App.Util.Capability.AppM (AppM)
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Unsafe.Coerce (unsafeCoerce)

component :: ∀ w i. Component Query (Input w i) Output AppM
component = mkComponent
  { initialState: κ
  , render: unsafeCoerce render
  , eval:
      mkEval 
      defaultEval 
      { handleAction = handleAction
      }
  }