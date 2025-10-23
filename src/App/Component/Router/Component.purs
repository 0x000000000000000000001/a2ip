module App.Component.Router.Component where

import Proem

import App.Component.Router.HandleAction (handleAction)
import App.Component.Router.HandleQuery (handleQuery)
import App.Component.Router.Render (render)
import App.Component.Router.Type (Action(..), Input, Output, Query)
import App.Util.Capability.AppM (AppM)
import App.Util.Capability.Navigate (Route(..))
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: κ
      { route: Home 
      , scrollFork: Nothing
      }
  , render
  , eval: mkEval defaultEval  
      { handleAction = handleAction 
      , handleQuery = handleQuery
      , initialize = Just Initialize
      }
  } 