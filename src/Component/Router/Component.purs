module Component.Router.Component where

import Prelude

import Capability.AppM (AppM)
import Component.Router.HandleQuery (handleQuery)
import Component.Router.Render (render)
import Component.Router.Route (Route(..))
import Component.Router.Type (Query)
 
import Halogen as H

component :: forall i o. H.Component Query i o AppM
component = H.mkComponent
  { initialState: const { route: Home }
  , render
  , eval: H.mkEval H.defaultEval 
      { handleQuery = handleQuery
      }
  }