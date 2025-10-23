module App.Component.Router.Menu.Component (component) where

import Proem hiding (top, div)

import App.Util.Capability.AppM.AppM (AppM)
import App.Component.Router.Menu.HandleAction (handleAction)
import App.Component.Router.Menu.Render (render)
import App.Component.Router.Menu.Type (Output, Query)
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Unit Output AppM
component = mkComponent
  { initialState: κ { isUnfold: false, isAnimating: false }
  , render
  , eval: mkEval defaultEval { handleAction = handleAction }
  } 