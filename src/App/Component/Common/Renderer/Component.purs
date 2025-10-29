module App.Component.Common.Renderer.Component
  ( component
  ) where

import Proem

import App.Component.Common.Modal.HandleAction (handleAction)
import App.Component.Common.Modal.Render (render)
import App.Component.Common.Modal.Type (Action(..), Input, Output)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component innerComponent = mkComponent
  { initialState: \input -> 
      { innerHtml: input.innerHtml
      }
  , render: render innerComponent
  , eval: 
      mkEval 
      defaultEval 
      { handleAction = handleAction
      }
  }