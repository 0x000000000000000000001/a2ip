module Component.Page.About.Render where

import Prelude hiding (div)

import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Page.About.Type (Action, State, Slots)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML (pre_, text)

render :: forall m. MonadAff m => Navigate m => Log m => State -> H.ComponentHTML Action Slots m
render state =
  case state.data of
    Nothing -> 
      if state.isLoading 
        then text "Loading..."
        else text ""
    
    Just csvData -> 
      pre_ [ text $ show csvData ]
