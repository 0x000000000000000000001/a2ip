module Component.Router.Menu.Component (component) where

import Prelude hiding (top, div)

import Capability.AppM (AppM)
import Component.Router.Menu.HandleAction (handleAction)
import Component.Router.Menu.Render (render)
import Component.Router.Menu.Type (Output)
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Halogen as H

component :: forall q. Component q Unit Output AppM
component = mkComponent
  { initialState: const { isUnfold: false }
  , render
  , eval: mkEval defaultEval { handleAction = handleAction }
  } 