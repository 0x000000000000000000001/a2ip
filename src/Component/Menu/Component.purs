module Component.Menu.Component (component) where

import Prelude hiding (top, div)

import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Component.Menu.Render (render)
import Component.Menu.HandleAction (handleAction)

component :: forall q o m. MonadAff m => H.Component q Unit o m
component = H.mkComponent
  { initialState: const { isUnfold: false }
  , render
  , eval: H.mkEval H.defaultEval { handleAction = handleAction }
  }