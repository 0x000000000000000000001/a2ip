module Component.Page.About.Component where

import Prelude

import AppM (AppM)
import Capability.Log (class Log)
import Capability.Navigate (class Navigate)
import Capability.ReadConfig (class ReadConfig)
import Component.Page.About.HandleAction (handleAction)
import Component.Page.About.Render (render)
import Component.Page.About.Type (Action(..), Input, Query)
import Data.Array (replicate)
import Data.Maybe (Maybe(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H

component :: forall o. H.Component Query Input o AppM
component = H.mkComponent
  { initialState: const
      { members: replicate 6 Nothing
      }
  , render
  , eval: H.mkEval H.defaultEval
      { handleAction = handleAction
      , initialize = Just LoadData
      } 
  }