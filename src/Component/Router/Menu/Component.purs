module Component.Router.Menu.Component (component) where

import Proem hiding (top, div)

import Capability.AppM (AppM)
import Component.Router.Menu.HandleAction (handleAction)
import Component.Router.Menu.Render (render)
import Component.Router.Menu.Type (Output, Query)
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Unit Output AppM
component = mkComponent
  { initialState: κ { isUnfold: false, isAnimating: false }
  , render
  , eval: mkEval defaultEval { handleAction = handleAction }
  } 