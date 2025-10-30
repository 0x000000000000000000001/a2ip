module App.Component.Router.Menu.Component (component) where

import Proem hiding (top, div)

import App.Util.Capability.AppM (AppM)
import App.Component.Router.Menu.HandleAction (handleAction)
import App.Component.Router.Menu.Render (render)
import App.Component.Router.Menu.Type (Action(..), Output, Query)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Unit Output AppM
component = mkComponent
  { initialState: κ { unfold: false, animating: false }
  , render
  , eval: mkEval defaultEval 
      { handleAction = handleAction
      , initialize = Just Initialize
      }
  } 