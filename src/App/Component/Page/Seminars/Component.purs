module App.Component.Page.Seminars.Component where

import Proem

import App.Component.Page.Seminars.HandleAction (handleAction)
import App.Component.Page.Seminars.Render (render)
import App.Component.Page.Seminars.Type (Action(..), Input, Output, Query, State(..))
import App.Util.Capability.AppM (AppM)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ Loading
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , initialize = Just Load
      }
  }