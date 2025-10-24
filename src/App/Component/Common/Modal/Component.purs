module App.Component.Common.Modal.Component
  ( component
  ) where

import Proem

import App.Component.Common.Modal.HandleAction (handleAction)
import App.Component.Common.Modal.Render (render)
import App.Component.Common.Modal.Type (Action(..), Input, Output, Query)
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: \input -> { closable: input.closable }
  , render
  , eval: mkEval defaultEval { handleAction = handleAction, receive = Just ◁ Receive }
  }