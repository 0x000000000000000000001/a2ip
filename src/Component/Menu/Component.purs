module Component.Menu.Component (component) where

import Prelude hiding (top, div)

import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Menu.HandleAction (handleAction)
import Component.Menu.Render (render)
import Component.Menu.Type (Output)
import Effect.Aff.Class (class MonadAff)
import Halogen as H

component :: forall q m. MonadAff m => Navigate m => Log m => H.Component q Unit Output m
component = H.mkComponent
  { initialState: const { isUnfold: false }
  , render
  , eval: H.mkEval H.defaultEval { handleAction = handleAction }
  }