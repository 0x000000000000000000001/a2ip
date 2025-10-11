module Component.Page.About.Component where

import Proem

import Capability.AppM (AppM)
import Component.Page.About.HandleAction (handleAction)
import Component.Page.About.Render (render)
import Component.Page.About.Type (Action(..), Input, Query, Output)
import Data.Array (replicate)
import Data.Maybe (Maybe(..))
import Halogen (Component, defaultEval, mkComponent, mkEval)

component :: Component Query Input Output AppM
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