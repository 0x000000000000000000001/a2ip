module Component.Router.Component where

import Proem

import Capability.AppM (AppM)
import Component.Router.HandleAction (handleAction)
import Component.Router.HandleQuery (handleQuery)
import Component.Router.Render (render)
import Component.Router.Route (Route(..))
import Component.Router.Type (Action(..), Input, Output, Query)
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