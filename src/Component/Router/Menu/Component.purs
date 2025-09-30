module Component.Router.Menu.Component (component) where

import Prelude hiding (top, div)

import AppM (AppM)
import Component.Router.Menu.HandleAction (handleAction)
import Component.Router.Menu.Render (render)
import Component.Router.Menu.Type (Output)
import Halogen as H

component :: forall q. H.Component q Unit Output AppM
component = H.mkComponent
  { initialState: const { isUnfold: false }
  , render
  , eval: H.mkEval H.defaultEval { handleAction = handleAction }
  }