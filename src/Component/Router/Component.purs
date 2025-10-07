module Component.Router.Component where

import Prelude

import Capability.AppM (AppM)
import Component.Router.HandleQuery (handleQuery)
import Component.Router.Render (render)
import Component.Router.Route (Route(..))
import Component.Router.Type (Input, Query, Output)
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
component = mkComponent
  { initialState: const { route: Home }
  , render
  , eval: mkEval defaultEval  
      { handleQuery = handleQuery
      }
  } 