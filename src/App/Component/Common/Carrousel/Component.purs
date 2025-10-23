module App.Component.Common.Carrousel.Component
  ( component
  ) where

import Proem

import App.Util.Capability.AppM (AppM)
import App.Component.Common.Carrousel.HandleAction (handleAction)
import App.Component.Common.Carrousel.Render (render)
import App.Component.Common.Carrousel.Type (Action(..), Input, Output, Query)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: \input -> { index: 0, imageSources: input.imageSources }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , receive = Just ◁ Receive
      }
  }