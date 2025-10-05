module Component.Router.Component where

import Prelude

import Capability.AppM (AppM)
import Component.Router.HandleQuery (handleQuery)
import Component.Router.Render (render)
import Component.Router.Route (Route(..))
import Component.Router.Type (Query)
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: forall i o. Component Query i o AppM
component = mkComponent
  { initialState: const { route: Home }
  , render
  , eval: mkEval defaultEval  
      { handleQuery = handleQuery
      }
  } 