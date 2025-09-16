module Component.Page.About.Component where

import Prelude

import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Component.Page.About.Render (render)
import Component.Page.About.Type (Action(..), Input, Query)
import Component.Page.About.HandleAction (handleAction)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H

component :: forall o m. MonadAff m => Navigate m => Log m => H.Component Query Input o m
component = H.mkComponent
  { initialState: const 
      { isLoading: true
      , data: Nothing
      }
  , render 
  , eval: H.mkEval H.defaultEval 
      { handleAction = handleAction
      , initialize = Just LoadSheetData
      }
  }