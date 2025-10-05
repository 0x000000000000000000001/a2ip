module Component.Page.About.Component where

import Prelude

import Capability.AppM (AppM)
import Component.Page.About.HandleAction (handleAction)
import Component.Page.About.Render (render)
import Component.Page.About.Type (Action(..), Input, Query)
import Data.Array (replicate)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)
import Halogen as H

component :: forall o. Component Query Input o AppM
component = mkComponent
  { initialState: const
      { members: replicate 6 Nothing
      }
  , render
  , eval: mkEval defaultEval
      { handleAction = handleAction
      , initialize = Just LoadData
      } 
  }