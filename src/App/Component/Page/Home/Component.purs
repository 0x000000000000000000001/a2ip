module App.Component.Page.Home.Component where

import Proem

import App.Util.Capability.AppM (AppM)
import App.Component.Page.Home.HandleAction (handleAction)
import App.Component.Page.Home.Render (render)
import App.Component.Page.Home.Type (Action(..), Input, Query, Output)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κηι
  , render
  , eval: mkEval defaultEval
  }