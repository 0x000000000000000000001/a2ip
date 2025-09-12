module Component.Menu.Component (component) where

import Prelude hiding (top, div)

import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Component.Menu.Render (render)
import Component.Menu.HandleAction (handleAction)
import Component.Menu.Type (Output)

component :: forall q m. MonadAff m => H.Component q Unit Output m
component = H.mkComponent
  { initialState: const { isUnfold: false }
  , render
  , eval: H.mkEval H.defaultEval { handleAction = handleAction }
  }