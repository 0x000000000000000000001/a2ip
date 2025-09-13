module Component.Router.Component where

import Prelude

import Component.Router.HandleQuery (handleQuery)
import Component.Router.Render (render)
import Component.Router.Route (Route(..))
import Component.Router.Type (Query)
import Effect.Aff.Class (class MonadAff)
import Halogen as H

component :: forall i o m. MonadAff m => H.Component Query i o m
component = H.mkComponent
  { initialState: const { route: Home }
  , render: render
  , eval: H.mkEval H.defaultEval 
      { handleQuery = handleQuery
      }
  }
